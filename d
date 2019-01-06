[33mcommit 30c436cc964e6757e6e61dffb36bc55e34b93a13[m[33m ([m[1;36mHEAD -> [m[1;32mmaster[m[33m, [m[1;31morigin/master[m[33m)[m
Author: Cezik <czepek221@gmail.com>
Date:   Sat Jan 5 17:04:00 2019 +0100

    Working with comments controller

[1mdiff --git a/app/assets/stylesheets/custom.scss b/app/assets/stylesheets/custom.scss[m
[1mindex 9325db2..6cc16c8 100644[m
[1m--- a/app/assets/stylesheets/custom.scss[m
[1m+++ b/app/assets/stylesheets/custom.scss[m
[36m@@ -1,7 +1,13 @@[m
 @import "bootstrap-sprockets";[m
 @import "bootstrap";[m
 [m
[32m+[m[32mbody[m
[32m+[m[32m{[m
[32m+[m[32m  padding: 50px;[m
[32m+[m[32m}[m
[32m+[m
 .info[m
 {[m
[32m+[m[32m  text-align: center;[m
   font-weight: bold;[m
 }[m
[1mdiff --git a/app/controllers/articles_controller.rb b/app/controllers/articles_controller.rb[m
[1mindex 682c493..4daf954 100644[m
[1m--- a/app/controllers/articles_controller.rb[m
[1m+++ b/app/controllers/articles_controller.rb[m
[36m@@ -28,7 +28,7 @@[m [mclass ArticlesController < ApplicationController[m
 [m
   def show[m
     @article = Article.find(params[:id])[m
[31m-    # render[m
[32m+[m[32m    @comment = @article.comments.new[m
   end[m
 [m
   def edit[m
[1mdiff --git a/app/views/articles/show.html.erb b/app/views/articles/show.html.erb[m
[1mindex eda2bc7..5484f0d 100644[m
[1m--- a/app/views/articles/show.html.erb[m
[1m+++ b/app/views/articles/show.html.erb[m
[36m@@ -5,3 +5,23 @@[m
 </p>[m
 [m
 <%= link_to t('articles.show.index_link'), articles_path, class: 'btn btn-info'  %>[m
[32m+[m
[32m+[m[32m<br/><br/><hr/>[m
[32m+[m
[32m+[m[32m<%= simple_form_for @comment, url: article_comments_path(@article.id), wrapper: :horizontal_form do |f| %>[m
[32m+[m[32m  <%= f.input :commenter %>[m
[32m+[m[32m  <%= f.input :body %>[m
[32m+[m[32m  <div class="form-group row mb-0">[m
[32m+[m[32m    <div class="col-sm-9 offset-sm-3">[m
[32m+[m[32m      <%= f.button :submit, class: 'btn-success' %>[m
[32m+[m[32m    </div>[m
[32m+[m[32m  </div>[m
[32m+[m[32m<% end %>[m
[32m+[m
[32m+[m[32m<br/><br/><hr/>[m
[32m+[m
[32m+[m[32m<% @article.comments.reject(&:new_record?).each do |comment| %>[m
[32m+[m[32m  <div>[m
[32m+[m[32m    <strong><%= comment.commenter %>:</strong> <%= comment.body %>[m
[32m+[m[32m  </div>[m
[32m+[m[32m<% end %>[m
[1mdiff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb[m
[1mindex 8e434a4..5282b5d 100644[m
[1m--- a/app/views/layouts/application.html.erb[m
[1m+++ b/app/views/layouts/application.html.erb[m
[36m@@ -19,7 +19,7 @@[m
       <% end %>[m
     </div>[m
 [m
[31m-    <div id="main-container" class="container">[m
[32m+[m[32m    <div class="container">[m
       <div class="row">[m
         <div class="col-xs-9">[m
           <%= yield %>[m
[1mdiff --git a/config/locales/pl.yml b/config/locales/pl.yml[m
[1mindex b3e21d3..1c1fbc0 100644[m
[1m--- a/config/locales/pl.yml[m
[1m+++ b/config/locales/pl.yml[m
[36m@@ -12,7 +12,7 @@[m [mpl:[m
     new:[m
       title: 'Dodaj nowy artykuł'[m
     show:[m
[31m-      index_link: Wróć do listy[m
[32m+[m[32m      index_link: 'Wróć do listy'[m
     index:[m
       title: Tytuł[m
       date: Data utworzenia[m
[36m@@ -33,6 +33,10 @@[m [mpl:[m
     submit:[m
       create: 'Utwórz %{model}'[m
 [m
[32m+[m[32m  comments:[m
[32m+[m[32m    create:[m
[32m+[m[32m      error: 'Nie można dodać komentarza: %{problems}'[m
[32m+[m
   activerecord:[m
     models:[m
       article: 'Artykuł'[m
[36m@@ -45,8 +49,10 @@[m [mpl:[m
             text:[m
               cannot_contain_title: nie może zawierać tytułu artykułu[m
               blank: nie może być pusty[m
[31m-[m
     attributes:[m
       article:[m
         title: 'Tytuł artykułu'[m
         text: 'Tekst artykułu'[m
[32m+[m[32m      comment:[m
[32m+[m[32m        commenter: 'Twój pseudonim:'[m
[32m+[m[32m        body: 'Komentarz:'[m
