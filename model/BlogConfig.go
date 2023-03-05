package model

type BlogConfig struct {
	BaseModel
	Config string `gorm:"type:varchar(2000);comment:配置信息" json:"config"`
}

type BlogConfigDetail struct {
	// 网站信息
	WebsiteAvatar     string `json:"website_avatar"`                                                 // 网站头像
	WebsiteName       string `json:"website_name"`                                                   // 网站名称
	WebsiteAuthor     string `json:"website_author"`                                                 // 网站作者
	WebsiteIntro      string `json:"website_intro"`                                                  // 网站简介
	WebsiteNotice     string `json:"website_notice"`                                                 // 网站公告
	WebsiteCreateTime string `json:"website_createtime" time_format:"sql_datetime" time_utc:"false"` // 网站创建时间
	WebsiteRecord     string `json:"website_record"`                                                 // 网站备案号
	RecordInfoUrl     string `json:"record_info_url"`                                                // 备案信息链接
	BkImg             string `json:"bk_img"`                                                         // 主页背景图
	AuthorBkImg       string `json:"author_bk_img"`                                                  // 作者介绍背景图

	// 社交信息
	SocialLoginList []string `json:"social_login_list"` // 第三方登录
	SocialUrlList   []string `json:"social_url_list"`   // 登录地址
	GithubPage      string   `json:"github"`            //Github首页

	// 其他信息
	TouristAvatar   string `json:"tourist_avatar"`    // 默认游客头像
	UserAvatar      string `json:"user_avatar"`       // 默认用户头像
	ArticleCover    string `json:"article_cover"`     // 默认文章封面
	IsCommentReview *int8  `json:"is_comment_review"` //评论默认审核
	IsMessageReview *int8  `json:"is_message_review"` //留言默认审核
	IsEmailNotice   *int8  `json:"is_email_notice"`   // 邮箱通知
	//IsReward *int8 `json:"is_reward"` // 打赏状态
	//WeiXinQRCode    string `json:"wechat_qrcode"`     // 微信收款码图片
	//AlipayQRCode    string `json:"alipay_ode"`        // 支付宝收款码图片
	// IsChatRoom      int    `json:"is_chatroom"`       // 聊天室状态
	// WebsocketUrl    string `json:"websocket_url"`     // websocket 地址
	// IsMusicPlayer   int    `json:"is_music_player"`   // 音乐播放器状态
	ExampleIntro string `json:"example_intro"`
	ExampleUrl   string `json:"example_url"`
}

type Sentence struct {
	ID      int    `json:"id"`
	Content string `json:"sentence"`
	Author  string `json:"author"`
}
