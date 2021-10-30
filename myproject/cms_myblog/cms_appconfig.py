from aldryn_apphooks_config.models import AppHookConfig
from aldryn_apphooks_config.utils import setup_config
from app_data import AppDataForm
from django.db import models
from django import forms
from django.utils.translation import ugettext_lazy as _
from filer.models import ThumbnailOption
from meta import settings as meta_settings

from parler.models import TranslatableModel, TranslatedFields

AVAILABLE_PERMALINK_STYLES = (  # noqa
    ("full_date", _("Full date")),
    ("short_date", _("Year /  Month")),
    ("category", _("Category")),
    ("slug", _("Just slug")),
)

MENU_TYPES = (  # noqa
    ("complete", _("Categories and posts")),
    ("categories", _("Categories only")),
    ("posts", _("Posts only")),
    ("none", _("None")),
)


SITEMAP_CHANGEFREQ_LIST = (  # noqa
    ("always", _("always")),
    ("hourly", _("hourly")),
    ("daily", _("daily")),
    ("weekly", _("weekly")),
    ("monthly", _("monthly")),
    ("yearly", _("yearly")),
    ("never", _("never")),
    )

class BlogConfig(TranslatableModel, AppHookConfig): #BlogConfig
    """
    Adds translatable, per-app-instance fields.
    """
    translations = TranslatedFields(
    app_title=models.CharField(_("application title"), default="Blog", max_length=234),
    object_name=models.CharField(_("object name"), max_length=234, default="Article"),
    )

    paginate_by = models.PositiveIntegerField(
        _('Paginate size'),
        blank=False,
        default=5,
    )


    class Meta:
        verbose_name = _("blog config")
        verbose_name_plural = _("blog configs")

    def get_app_title(self):
        return getattr(self, "app_title", _("untitled"))

    @property
    def schemaorg_type(self):
        """Compatibility shim to fetch data from legacy gplus_type field."""
        return self.gplus_type


class BlogConfigForm(AppDataForm):
    """
    Settings that can be changed per-apphook.
    Their default value is the same as the corresponding Django settings,
    but it can be customized per each apphook and changed at runtime.
    """

    title = forms.CharField()

    app_title = "Blog"
    """
    Free text title that can be used as title in templates
    """
    object_name = "Article"
    """
    Free text label for Blog items in django CMS Wizard
    """
    #: Post published by default (default: :ref:`DEFAULT_PUBLISHED <DEFAULT_PUBLISHED>`)
    default_published = forms.BooleanField(
        label=_("Post published by default"), required=False, initial=False
    )
    #: Default size of full images
    default_image_full = forms.ModelChoiceField(
        label=_("Default size of full images"),
        queryset=ThumbnailOption.objects.all(),
        required=False,
        help_text=_("If left empty the image size will have to be set for every newly created post."),
    )
    #: Default size of thumbnail images
    default_image_thumbnail = forms.ModelChoiceField(
        label=_("Default size of thumbnail images"),
        queryset=ThumbnailOption.objects.all(),
        required=False,
        help_text=_("If left empty the thumbnail image size will have to be set for every newly created post."),
    )
    #: Structure of permalinks (get_absolute_url); see :ref:`AVAILABLE_PERMALINK_STYLES <AVAILABLE_PERMALINK_STYLES>`
    url_patterns = forms.ChoiceField(
        label=_("Permalink structure"),
        required=False,
        initial="full_date",
        choices=AVAILABLE_PERMALINK_STYLES,
    )
    #: Use placeholder and plugins for article body (default: :ref:`USE_PLACEHOLDER <USE_PLACEHOLDER>`)
    use_placeholder = forms.BooleanField(
        label=_("Use placeholder and plugins for article body"), required=False, initial=True,
    )
    #: Use abstract field (default: :ref:`USE_ABSTRACT <USE_ABSTRACT>`)
    use_abstract = forms.BooleanField(
        label=_("Use abstract field"), required=False, initial=True
    )
    #: Enable related posts (default: :ref:`USE_RELATED <USE_RELATED>`)
    use_related = forms.BooleanField(
        label=_("Enable related posts"), required=False, initial=True
    )
    #: Set author by default (default: :ref:`AUTHOR_DEFAULT <AUTHOR_DEFAULT>`)
    set_author = forms.BooleanField(
        label=_("Set author"),
        required=False,
        help_text=_("Set author by default"),
        initial=True,
    )
    #: When paginating list views, how many articles per page? (default: :ref:`PAGINATION <PAGINATION>`)
    paginate_by = forms.IntegerField(
        label=_("Paginate size"),
        required=False,
        initial=10,
        help_text=_("When paginating list views, how many articles per page?"),
    )
    #: Alternative directory to load the blog templates from (default: "")
    template_prefix = forms.CharField(
        label=_("Template prefix"),
        required=False,
        initial="",
        help_text=_("Alternative directory to load the blog templates from"),
    )
    #: Menu structure (default: ``MENU_TYPE_COMPLETE``, see :ref:`MENU_TYPES <MENU_TYPES>`)
    menu_structure = forms.ChoiceField(
        label=_("Menu structure"),
        required=True,
        choices=MENU_TYPES,
        initial="complete",
        help_text=_("Structure of the django CMS menu"),
    )
    #: Show empty categories in menu (default: :ref:`MENU_EMPTY_CATEGORIES <MENU_EMPTY_CATEGORIES>`)
    menu_empty_categories = forms.BooleanField(
        label=_("Show empty categories in menu"),
        initial=True,
        required=False,
        help_text=_("Show categories with no post attached in the menu"),
    )
    #: Sitemap changefreq (default: :ref:`SITEMAP_CHANGEFREQ_DEFAULT <SITEMAP_CHANGEFREQ_DEFAULT>`,
    #: see: :ref:`SITEMAP_CHANGEFREQ <SITEMAP_CHANGEFREQ>`)
    sitemap_changefreq = forms.ChoiceField(
        label=_("Sitemap changefreq"),
        required=True,
        choices=SITEMAP_CHANGEFREQ_LIST,
        initial="monthly",
        help_text=_("Changefreq attribute for sitemap items"),
    )
    #: Sitemap priority (default: :ref:`SITEMAP_PRIORITY_DEFAULT <SITEMAP_PRIORITY_DEFAULT>`)
    sitemap_priority = forms.CharField(
        label=_("Sitemap priority"),
        required=True,
        initial="0.5",
        help_text=_("Priority attribute for sitemap items"),
    )
    #: Object type (default: :ref:`TYPE <TYPE>`, see :ref:`TYPES <TYPES>`)
    object_type = forms.ChoiceField(
        label=_("Object type"), required=False, choices=meta_settings.OBJECT_TYPES, initial="Article"
    )
    #: Facebook type (default: :ref:`FB_TYPE <FB_TYPE>`, see :ref:`FB_TYPES <FB_TYPES>`)
    og_type = forms.ChoiceField(
        label=_("Facebook type"), required=False, choices=meta_settings.FB_TYPES, initial="Article"
    )
    #: Facebook application ID (default: :ref:`FB_PROFILE_ID <FB_PROFILE_ID>`)
    og_app_id = forms.CharField(
        max_length=200, label=_("Facebook application ID"), required=False, initial=meta_settings.FB_PROFILE_ID
    )
    #: Facebook profile ID (default: :ref:`FB_PROFILE_ID <FB_PROFILE_ID>`)
    og_profile_id = forms.CharField(
        max_length=200, label=_("Facebook profile ID"), required=False, initial=meta_settings.FB_PROFILE_ID
    )
    #: Facebook page URL (default: :ref:`FB_PUBLISHER <FB_PUBLISHER>`)
    og_publisher = forms.CharField(
        max_length=200, label=_("Facebook page URL"), required=False, initial=meta_settings.FB_PUBLISHER
    )
    #: Facebook author URL (default: :ref:`FB_AUTHOR_URL <FB_AUTHOR_URL>`)
    og_author_url = forms.CharField(
        max_length=200, label=_("Facebook author URL"), required=False, initial="get_author_url"
    )
    #: Facebook author (default: :ref:`FB_AUTHOR <FB_AUTHOR>`)
    og_author = forms.CharField(
        max_length=200, label=_("Facebook author"), required=False, initial="get_author_name"
    )
    #: Twitter type field (default: :ref:`TWITTER_TYPE <TWITTER_TYPE>`)
    twitter_type = forms.ChoiceField(
        label=_("Twitter type"),
        required=False,
        choices=meta_settings.TWITTER_TYPES,
        initial="summary"
    )
    #: Twitter site handle (default: :ref:`TWITTER_SITE <TWITTER_SITE>`)
    twitter_site = forms.CharField(
        max_length=200, label=_("Twitter site handle"), required=False, initial=None
    )
    #: Twitter author handle (default: :ref:`TWITTER_AUTHOR <TWITTER_AUTHOR>`)
    twitter_author = forms.CharField(
        max_length=200, label=_("Twitter author handle"), required=False, initial="get_author_twitter"
    )
    #: Schema.org object type (default: :ref:`SCHEMAORG_TYPE <SCHEMAORG_TYPE>`)
    gplus_type = forms.ChoiceField(
        label=_("Schema.org type"),
        required=False,
        choices=meta_settings.SCHEMAORG_TYPES,
        initial="Blog",
    )
    #: Schema.org author name abstract field (default: :ref:`SCHEMAORG_AUTHOR <SCHEMAORG_AUTHOR>`)
    gplus_author = forms.CharField(
        max_length=200, label=_("Schema.org author name"), required=False, initial="get_author_schemaorg"
    )
    #: Send notifications on post update. Require channels integration
    send_knock_create = forms.BooleanField(
        label=_("Send notifications on post publish"),
        required=False,
        initial=False,
        help_text=_("Emits a desktop notification -if enabled- when publishing a new post"),
    )
    #: Send notifications on post update. Require channels integration
    send_knock_update = forms.BooleanField(
        label=_("Send notifications on post update"),
        required=False,
        initial=False,
        help_text=_("Emits a desktop notification -if enabled- when editing a published post"),
    )


setup_config(BlogConfigForm, BlogConfig)
