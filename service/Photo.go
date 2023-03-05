package service

type Photo struct{}

func (*Photo) GetList() []string {
	list, _ := photoDAO.GetList()
	return list
}
