// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

// スプラッシュ画面
$(function() {
   setTimeout(function(){
      $('.start p').fadeIn(1600);
   },500); //0.5秒後にロゴをフェードイン!
   setTimeout(function(){
      $('.start').fadeOut(500);
   },2500); //2.5秒後にロゴ含め真っ白背景をフェードアウト！
});

// プレビュー
$(function() {
 function readURL(input) {
   if (input.files && input.files[0]) {
     var reader = new FileReader();
     reader.onload = function (e) {
       $('#img_prev').attr('src', e.target.result);
     }
     reader.readAsDataURL(input.files[0]);
   }
 }
 $("#image").change(function(){
   readURL(this);
 });
});