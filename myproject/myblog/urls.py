from django.shortcuts import render
from django.urls import path

from .feeds import FBInstantArticles, LatestEntriesFeed, TagFeed

from .views import (
    AuthorEntriesView,
    CategoryEntriesView,
    PostArchiveView,
    PostDetailView,
    PostListView,
    TaggedListView,
)


PERMALINK_TYPE_FULL_DATE = "full_date"
PERMALINK_TYPE_SHORT_DATE = "short_date"
PERMALINK_TYPE_CATEGORY = "category"
PERMALINK_TYPE_SLUG = "slug"

PERMALINKS_URLS = {  # noqa
    PERMALINK_TYPE_FULL_DATE: "<int:year>/<int:month>/<int:day>/<str:slug>/",
    PERMALINK_TYPE_SHORT_DATE: "<int:year>/<int:month>/<str:slug>/",
    PERMALINK_TYPE_CATEGORY: "<str:category>/<str:slug>/",
    PERMALINK_TYPE_SLUG: "<str:slug>/",
}

def get_urls():
    urls = PERMALINKS_URLS
    details = []
    for urlconf in urls.values():
        details.append(
            path(urlconf, PostDetailView.as_view(), name="post-detail"),
        )
    return details


detail_urls = get_urls()

# module-level app_name attribute as per django 1.9+
app_name = "myblog"
urlpatterns = [
    path("", PostListView.as_view(), name="posts-latest"),#OK
    path("feed/", LatestEntriesFeed(), name="posts-latest-feed"),
    path("feed/fb/", FBInstantArticles(), name="posts-latest-feed-fb"),
    path("<int:year>/", PostArchiveView.as_view(), name="posts-archive"),
    path("<int:year>/<int:month>/", PostArchiveView.as_view(), name="posts-archive"),
    path("author/<str:username>/", AuthorEntriesView.as_view(), name="posts-author"),#OK tous les articles de l'auteur
    path("category/<str:category>/", CategoryEntriesView.as_view(), name="posts-category"), #OK clicquer pour visionnaliser toute la category donnee
    path("tag/<slug:tag>/", TaggedListView.as_view(), name="posts-tagged"),
    path("tag/<slug:tag>/feed/", TagFeed(), name="posts-tagged-feed"),
] + detail_urls
