package req

type AddOrEditPage struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Label string `json:"label"`
	Cover string `json:"cover"`
}

type GetPage struct {
	PageName string `form:"page_name" json:"page_name"`
}
