const cloudinary = require("cloudinary").v2;
const User = require("../Models/User.js");
require("dotenv").config();

// Configure Cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_ClOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

const getPresignedUrl = async (req, res) => {
  const filename = req.query.filename;
  const filetype = req.query.filetype;

  if (!filename || !filetype) {
    return res
      .status(400)
      .json({ error: "Filename and filetype are required" });
  }

  if (!filetype.startsWith("image/")) {
    return res.status(400).json({ error: "Invalid file type" });
  }

  const userId = req.user.id;

  try {
    // Generate timestamp for signature
    const timestamp = Math.round(new Date().getTime() / 1000);
    
    // Create upload parameters
    const uploadParams = {
      timestamp: timestamp,
      folder: `conversa/${userId}`,
      resource_type: "image"
    };

    // Generate signature
    const signature = cloudinary.utils.api_sign_request(uploadParams, process.env.CLOUDINARY_API_SECRET);

    // Return the upload URL and parameters needed for frontend
    const uploadData = {
      url: `https://api.cloudinary.com/v1_1/${process.env.CLOUDINARY_ClOUD_NAME}/image/upload`,
      fields: {
        ...uploadParams,
        signature: signature,
        api_key: process.env.CLOUDINARY_API_KEY
      }
    };

    return res.status(200).json(uploadData);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

const getOnlineStatus = async (req, res) => {
  const userId = req.params.id;
  try {
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.status(200).json({ isOnline: user.isOnline });
  } catch (error) {
    console.log(error);
    res.status(500).send("Internal Server Error");
  }
};

module.exports = { getPresignedUrl, getOnlineStatus };
