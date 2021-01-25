var express = require("express");
var router = express.Router();
var db= require("../config/database");
const { body, validationResult} = require('express-validator');
const UserModel= require('../models/Users')
const UserError =require("../helpers/error/UserError");
const {successPrint,errorPrint}=require("../helpers/debug/debugprinters");
var bcrypt=require('bcrypt');

const userValidationRules = () => {
    return [

        body('username').notEmpty().isAlphanumeric(),

        body('email').matches(/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/),

        body('password').matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z*-+-./!@#$()^&*]{8,}$/)
    ]
}

const validate = (req, res, next) => {
    const errors = validationResult(req)
    if (errors.isEmpty()) {
        return next()
    }else{
        req.flash('error',"Enter Valid information");
        errorPrint("Validation Failed!!")
        res.redirect('/registration');
    }
}
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/register', userValidationRules(), validate,(req,res,next) =>{
    var username = req.body.username;
    var email = req.body.email;
    var password = req.body.password;

       UserModel.usernameExists(username)
        .then((userDoesNameExists) =>{
            if(userDoesNameExists){
                throw new UserError(
                    "Registration Failed:Username already exist!!",
                    "/registration",
                    200
                );
            } else {
                return UserModel.emailExists(email);
            }
    })
    .then((emailDoesExists) => {
        if(emailDoesExists){
            throw new UserError(
                "Registration Failed:Email already exist!!",
                "/registration",
                200
            );
        }else{
            return UserModel.create(username, password, email);
        }
    })
    .then((createUserId) => {
        if (createUserId < 0) {
            throw new UserError(
                "Server Error: User cannot be created",
                "/registration",
                500
            );
        } else {
            successPrint("Users.js -->User was created!!");
            req.flash('success', 'User account was created');
            res.redirect('/login');
        }
    })
    .catch((err) => {
            errorPrint("user cannot be made", err);
            if (err instanceof UserError) {
                errorPrint(err.getMessage());
                req.flash('error', err.getMessage());
                res.status(err.getStatus());
                res.redirect(err.getRedirectURL());
            } else {
                next(err);
            }
        });
    });



router.post('/login',(req,res,next) =>
{
let username=req.body.username;
let password=req.body.password;
    UserModel.authenticate(username,password)
        .then((loggedUserId)=>{
            if(loggedUserId > 0){
                successPrint(`User ${username} is logged in`);
                req.flash('success','you have been successfully logged in!!');
                req.session.username=username;
                req.session.userId=loggedUserId;
                res.locals.logged = true;
                res.redirect("/");
            }else{
                throw new UserError("Invalid username and/or password!","/login",200);
            }
        })
        .catch((err) => {
            errorPrint("User login failed!!");
            if (err instanceof UserError){
                errorPrint(err.getMessage());
                req.flash('error',err.getMessage());
                res.status(err.getStatus());
                res.redirect('/login');
            }
            else{
                next(err);
            }
        });
});

router.post('/logout', (req, res, next) => {
    req.session.destroy((err) => {
        if (err) {
            errorPrint("session couldn't be destroyed");
            next(err);
        } else {
            successPrint("session was destroyed");
            res.clearCookie('csid');
            res.json({status: "OK", message: "user is logged out"});


        }
    })
})
module.exports = router;
