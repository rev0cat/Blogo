package req

// 新增或更新资源
type AddOrUpdateResource struct {
	ID            int    `json:"id"`
	Url           string `json:"url" mapstructure:"url"`
	RequestMethod string `json:"requestMethod" mapstructure:"requestMethod"`
	Name          string `json:"name" mapstructure:"name"`
	ParentID      int    `json:"parentID" mapstructure:"parentID,omitempty"`
}

type UpdateAnonymous struct {
	ID            int    `json:"id" validate:"required"`
	Url           string `json:"url" validate:"required" mapstructure:"url"`
	RequestMethod string `json:"requestMethod" validate:"required" mapstructure:"requestMethod"`
	Name          string `json:"name" validate:"required" mapstructure:"name"`
	IsAnonymous   *int8  `json:"isAnonymous" validate:"required,min=0,max=1" mapstructure:"isAnonymous"`
}
