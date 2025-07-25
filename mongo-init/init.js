// MongoDB initialization script for chat app
// This script creates initial collections and indexes

// Switch to chat app database
db = db.getSiblingDB('mern-chat-app');

// Create collections
db.createCollection('users');
db.createCollection('conversations');
db.createCollection('messages');

// Create indexes for better performance
print('Creating indexes...');

// User indexes
db.users.createIndex({ "email": 1 }, { unique: true });
db.users.createIndex({ "username": 1 });
db.users.createIndex({ "isOnline": 1 });

// Conversation indexes
db.conversations.createIndex({ "members": 1 });
db.conversations.createIndex({ "updatedAt": -1 });

// Message indexes
db.messages.createIndex({ "conversationId": 1, "createdAt": -1 });
db.messages.createIndex({ "sender": 1 });
db.messages.createIndex({ "seenBy.user": 1 });

print('Database initialization completed!');
print('Collections created: users, conversations, messages');
print('Indexes created for optimal performance');
