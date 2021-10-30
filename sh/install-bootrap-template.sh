#!/bin/bash
cp -r $PWD/BizLand/assets  $PWD/myproject/static/assets
if [ $? -eq 0 ]; then
    echo "cp -r BizLand/assets  ./myproject/static/assets     OK"
else
    echo "djangocms-installer    FAIL"
fi

cp -r $PWD/BizLand/index.html $PWD/myproject/myproject/templates/index.html
if [ $? -eq 0 ]; then
    echo "BizLand/index.html  myproject/myproject/templates/index.html     OK"
else
    echo "djangocms-installer    FAIL"
fi

#sed -i 's/old-text/new-text/g' input.txt
#sed  -i "s/('sidebar_right.html', 'Sidebar Right')/g"
PATTERN="sidebar_right"

SETTINGS_FILE="/Users/whodunit/WEB_APP/bash_auto/myproject/myproject/settings.py"

LINE_NUMBER=$(grep -wn $PATTERN  $SETTINGS_FILE | cut -d: -f1)

if [ $? -eq 0 ]; then
    echo "Line Number $LINE_NUMBER                    OK"
else
    echo "Line Number                                 FAIL"
fi


#sed -i '' "s/\(\'sidebar_right\.html\'\, \'Sidebar Right\'\)\"/abc/" $PWD/myproject/myproject/settings.py

#sed -i  '' "s/(\'sidebar_right.html\'\, \'Sidebar Right\')/(\'sidebar_right.html\'\, \'Sidebar Right\')\,/" $PWD/myproject/myproject/settings.py
OLD_CMS_TEMPLATES="CMS_TEMPLATES = (
    ## Customize this
    ('fullwidth.html', 'Fullwidth'),
    ('sidebar_left.html', 'Sidebar Left'),
    ('sidebar_right.html', 'Sidebar Right')
)"

NEW_CMS_TEMPLATES="CMS_TEMPLATES = (
    ## Customize this
    ('fullwidth.html', 'Fullwidth'),
    ('sidebar_left.html', 'Sidebar Left'),
    ('sidebar_right.html', 'Sidebar Right'),
    ('index.html', 'MyHomeTemplates'),
    ('about.html', 'MyAboutTemplates'),
    ('blog.html', 'MyBlogTemplates'),
    ('maths.html', 'MyMathsTemplates'),
    ('physic.html', 'MyPhysicTemplates'),
    ('comp-science.html', 'MyComputerScienceTemplates'),
    ('contact.html', 'MyContactTemplates'),
    ('myblog-plugin.html', 'MyBlogPluginTemplates'),
)"

## declare an array variable
declare -a templates=( "('sidebar_right.html', 'Sidebar Right'),"
                       "('index.html', 'MyHomeTemplates'),"
                       "('about.html', 'MyAboutTemplates'),"
                       "('blog.html', 'MyBlogTemplates'),"
                       "('maths.html', 'MyMathsTemplates'),"
                       "('physic.html', 'MyPhysicTemplates'),"
                       "('comp-science.html', 'MyComputerScienceTemplates'),"
                       "('contact.html', 'MyContactTemplates'),"
                       "('myblog-plugin.html', 'MyBlogPluginTemplates')," )

# get length of an array
templateslength=${#templates[@]}

# use for loop to read all values and indexes
for (( index=0; index<${templateslength}; index++ ));
do
  myvar=$(expr $LINE_NUMBER + $index)
  #sed -i '' '211i\'$'\n''text to insert' $PWD/myproject/myproject/settings.py
  TMP_NAME=${templates[index]}
  sed -i '' '211i\
    '"${TMP_NAME}"'
  '  $PWD/myproject/myproject/settings.py
  if [ $? -eq 0 ]; then
      echo "sed copy template    ${templates[index]}    --->        OK"
  else
      echo "sed copy template                          -|||-      FAIL"
  fi

done


#sed -i '' "s/^(\'sidebar_right.html\'\, \'Sidebar Right\')/i before=me\nbefore2=me2/" $PWD/myproject/myproject/settings.py

#sed -i  '' "s/^(\'sidebar_right.html\'\, \'Sidebar Right\')/i, (\'sidebar_right.html\'\, \'Sidebar Right\')\,/" $PWD/myproject/myproject/settings.py

#line='sidebar_right.html'


#sed -i  '' "s/(\'sidebar_right.html\'\, \'Sidebar Right\')/(\'sidebar_right.html\'\, \'Sidebar Right\')\,/" $PWD/myproject/myproject/settings.py
sed -i  '' "s/\'NAME\'\: \'project.db\',/\'NAME\'\: BASE_DIR \/ \'project.db\'\,/" $PWD/myproject/myproject/settings.py

if [ $? -eq 0 ]; then
    echo "add BASE_DIR to database path    OK"
else
    echo "add BASE_DIR to database path    FAIL"
fi

declare -a custom_templates=("copy_modele_templates/about.html"
                  "copy_modele_templates/blog.html"
                  "copy_modele_templates/index.html"
                  "copy_modele_templates/comp-science.html"
                  "copy_modele_templates/contact.html"
                  "copy_modele_templates/maths.html"
                  "copy_modele_templates/myblog-plugin.html"
                  "copy_modele_templates/physic.html"
                  )

# get length of an array
custom_templateslength=${#custom_templates[@]}

for (( index=0; index<${custom_templateslength}; index++ ));
do
    TMP_NAME=${custom_templates[index]}
    cp -r $TMP_NAME $PWD/myproject/myproject/templates/
    if [ $? -eq 0 ]; then
          echo "copy custom templates    ${custom_templates[index]}    --->        OK"
    else
          echo "copy custom templa                                       -|||-      FAIL"
    fi
done

echo
echo "............................... BOOTSTRAP_TEMPLATES_SETTINGS :  ------->   OK"
