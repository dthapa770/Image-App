var express = require('express');
var router = express.Router();
const{getRecentPosts, getPostById, getCommentsByPostId}=require('../middleware/postsmiddleware');
var isLoggedIn = require('../middleware/routeprotectors').userIsLoggedIn;
var db=require("../config/database");

/* GET home page. */
router.get('/',getRecentPosts, function(req, res, next) {
  res.render('index',{title:"Image APP"});
});
router.get('/login', (req, res, next) =>
{
  res.render("login",{title:"Login"});
})
router.get('/registration', (req, res, next) =>
{
  res.render("registration",{title:"Register"});
})
router.use('/postimage',isLoggedIn);
router.get('/postimage', (req, res, next) =>
{
  res.render("postimage",{title:"Post Image"});
})
router.get("/post/:id(\\d+)",getPostById, getCommentsByPostId,(req,res,next) =>{
console.log()
 res.render("imagepost",{ title:`Post ${req.params.id}`});

});

module.exports = router;
