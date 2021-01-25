const {getNRecentPosts, getPostById} = require('../models/Posts');
const {getCommentsForPost} =require('../models/comments');
const postMiddleware = {};


postMiddleware.getRecentPosts= async function(req, res, next){
  try{
   let results= await getNRecentPosts(8);
   res.locals.results=results;
   if(results.length == 0){
   req.flash('error','No Post Created Yet!');
   }
   next();
  } catch(err){next(err)}
}
postMiddleware.getPostById = async function(req, res, next){
    try{
        let postId =req.params.id;
        let results =await getPostById(postId);
        if(results && results.length){
            res.locals.currentPost =results[0];
            next();
        } else{
            req.flash("error","This is not the post you are looking for");
            req.redirect('/');
        }
    } catch(error) {
        next(err);
    }
}
postMiddleware.getCommentsByPostId = async function(req,res,next){
    let postId= req.params.id;
    try{
        res.locals.currentPost.comments = await getCommentsForPost(postId);
        next();
    }
    catch(error){
    next(error);
    }
}
module.exports = postMiddleware;