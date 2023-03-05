package resp

import "Blogo/model"

type FriendLinkVO struct {
	ExampleName    string              `json:"example_name"`
	ExampleAvatar  string              `json:"example_avatar"`
	ExampleIntro   string              `json:"example_intro"`
	ExampleUrl     string              `json:"example_url"`
	FriendLinkList []model.FriendLink  `json:"friend_link_list"`
	Requirement    []model.Requirement `json:"requirement"`
}
