package entity

import "go.mongodb.org/mongo-driver/bson/primitive"

type Comment struct {
	Id          primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Reply       string             `bson:"reply" json:"reply"`
	Content     string             `bson:"content" json:"content"`
	Username    string             `bson:"username" json:"username"`
	Time        uint64             `bson:"time" json:"time"`
	Like        uint32             `bson:"like" json:"like"`
	Dislike     uint32             `bson:"dislike" json:"dislike"`
	SubComments []*Comment         `bson:"subComments" json:"subComments"`
}

type BookComments struct {
	Id         primitive.ObjectID   `bson:"_id,omitempty" json:"id"`
	BookId     uint32               `bson:"bookId" json:"bookId"`
	CommentIds []primitive.ObjectID `bson:"commentIds" json:"commentIds"`
}

type CommentWithUserProfile struct {
	*Comment
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`
}

type BookCommentsSnapshot struct {
	NumComments uint32                    `json:"numComments"`
	HotComments []*CommentWithUserProfile `json:"hotComments"`
}
