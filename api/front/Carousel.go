package front

import (
	"Blogo/utils/r"
	"github.com/gin-gonic/gin"
)

type Carousel struct{}

func (*Carousel) GetCarousel(c *gin.Context) {
	r.SuccessData(c, carouselService.GetCarousel())
}
