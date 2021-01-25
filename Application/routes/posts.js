var express=require('express');
var router=express.Router();
const {successPrint, errorPrint}=require("../helpers/debug/debugprinters");
var sharp=require('sharp');
var multer=require('multer');
var crypto=require('crypto');
var PostModel = require('../models/Posts');
var PostError=require('../helpers/error/PostError');

var storage=multer.diskStorage({
    destination: function(req, file, cb){
        cb(null,"public/images/uploads");
    },
    filename:function(req,file,cb){
        let fileExt= file.mimetype.split('/')[1];
        let randomName= crypto.randomBytes(22).toString("hex");
        cb(null, `${randomName}.${fileExt}`);
    }
});

var uploader= multer({storage: storage});

router.post('/createPost',uploader.single("uploadImage"),(req,res,next)=>{
    var fileUploaded = req.file.path;
    var title = req.body.titlePost;
        var description = req.body.descriptionPost;
        var fk_userId = req.session.userId;
    var fileAsThumbnail = `thumbnail-${req.file.filename}`;
    var destinationOfThumbnail = req.file.destination + "/" + fileAsThumbnail;

            if(!title || !description || !req.file || !req.file.path || title.length === 0
                || description.length === 0 || fk_userId.length === 0) {
                errorPrint("Fields are empty!!");
                req.flash('error',"Fields cannot be empty!")
                res.redirect('/postimage');
            }else{
            sharp(fileUploaded)
                .resize(200)
                .toFile(destinationOfThumbnail)
                .then(() => {


                    return PostModel.create(title, description, fileUploaded, destinationOfThumbnail, fk_userId);
                })
                .then((postWasCreated) => {
                    if (postWasCreated) {
                        req.flash("success", "Your Post is created successfully");
                        res.redirect('/');
                    } else {
                        throw new PostError("Post could not be created!!", "postImage", 200);
                    }
                })
                .catch((err) => {
                    console.log(err)
                    if (err instanceof PostError) {
                        errorPrint(err.getMessage());
                        req.flash('error', err.getMessage());
                        res.status(err.getStatus());
                        res.redirect(err.getRedirectURL());
                    } else {
                        next(err);
                    }
                })


        }
});

router.get('/search', async(req, res, next) => {
    try {
        let searchTerm = req.query.search;
        if (!searchTerm) {
            res.send({

                message: "No search term given",
                results: []
            });
        } else {
            let results = await PostModel.search(searchTerm);
            if (results.length) {
                res.send({

                    message: `${results.length} results found`,
                    results: results
                });
            } else {
                let results = await PostModel.getNRecentPosts(8);
                res.send({

                    message: "No results found for search but take a look at 8 recent posts",
                    results: results
                });
            }
        }

    }
    catch(err){next(err);}
});
module.exports=router;