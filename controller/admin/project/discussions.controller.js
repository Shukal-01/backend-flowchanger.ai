const express = require('express');
const { PrismaClient } = require('@prisma/client');

const app = express();
const prisma = new PrismaClient();

// Add Discussion
const addDiscussionDetails = async(req,res) => {
    const {projectId, subject, discription,last_activity,total_comments,visible_to_customer} = req.body;
    try{
        const newDiscussionsData = await prisma.discussion.create({
            data:{
                projectId,
                subject,
                discription,
                last_activity,
                total_comments,
                visible_to_customer:visible_to_customer || false
            }
        });
        return res.status(200).json({status:200,message:"Discussions Created Successfully!",data:newDiscussionsData});
    }catch(error){
        return res.status(500).json({status:500,message:"failed to create discussion!",error:error.message});
    }
}

// Get Discussions
const getDiscussions = async(req, res) => {
    const { id } = req.params;
    
    try {        
        const getAllDiscussions = await prisma.discussion.findMany({
            where: id ? { id } : {},    
        });

        if (getAllDiscussions.length === 0) {
            return res.status(400).json({ status: 400, message: "Discussions not found!" });
        }

        return res.status(200).json({ status: 200, message: "Discussions fetched successfully", data: getAllDiscussions });

    } catch (error) {
        return res.status(500).json({ status: 500, message: "Failed to get discussions!", error });
    }
};

// Delete Discussions By Id
const deleteDiscussions = async(req,res) => {
    const {id} = req.params;    
        try{
            const deleteData = await prisma.discussion.delete({
                where:{
                    id: id,
                } 
            });
            res.status(200).json({status:200,message:"Discussion delete successfully"});                         
        }catch(error){
            res.status(500).json({status:500,message:"failed to delete discussion!"});
        }       
}

// update discussions
const updateDiscussions = async(req, res) => {
    const {id} = req.params;      
    try{
        const {projectId, subject, discription,last_activity,total_comments,visible_to_customer} = req.body;
       const updateData = await prisma.discussion.update({
            where:{
                id:id,
            },
            data:{
                projectId,
                subject,
                discription,
                last_activity,
                total_comments,
                visible_to_customer:visible_to_customer || false
            },
        })
        return res.json({status:200, message:"Discussion updated successfully!", data:updateData});
    } catch (error){
            if(error.code){
                return res.status(400).json({status:400, message:"Discussion not found!"});
            }            
    }
    
}


module.exports = {addDiscussionDetails, getDiscussions, deleteDiscussions, updateDiscussions}