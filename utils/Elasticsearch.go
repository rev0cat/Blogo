package utils

import (
	"Blogo/config"
	"context"
	"io"
	"log"
	"strconv"
	"strings"

	"github.com/elastic/go-elasticsearch/v7"
	"github.com/elastic/go-elasticsearch/v7/esapi"
)

const ElasticsearchErrPrefix = "utils/Elasticsearch.go -> "

type _Elasticsearch struct{}

type Body struct {
	ID      int    `json:"id"`
	Title   string `json:"title"`
	Content string `json:"content"`
}

var (
	Elasticsearch = new(_Elasticsearch)
	ES            *elasticsearch.Client
)

func InitElasticsearch() *elasticsearch.Client {
	cfg := elasticsearch.Config{
		Addresses: []string{config.Cfg.Elasticsearch.Address},
	}
	ES, _ = elasticsearch.NewClient(cfg)
	//res, _ := ES.Info()
	log.Println("Elasticsearch连接成功!")
	return ES
}

// TODO:Elasticsearch写入
// func (*_Elasticsearch) UpdateIndex(body, DocumentID string) {
// 	req := esapi.IndexRequest{
// 		DocumentID: DocumentID,
// 		Index:      "blogo",
// 		Body:       strings.NewReader(body),
// 		Refresh:    "true",
// 	}
// 	res, err := req.Do(ctx, ES)
// 	if err != nil {
// 		log.Panic("Elasticsearch写入失败:", err)
// 	}
// 	defer res.Body.Close()
// }

// TODO:Elasticsearch删除
func (*_Elasticsearch) Delete(docID string) {
	req := esapi.DeleteRequest{
		Index:        "blogo",
		DocumentType: "_doc",
		DocumentID:   docID,
	}
	res, err := req.Do(ctx, ES)
	if err != nil {
		log.Panic("Elasticsearch删除失败:", err)
	}
	defer res.Body.Close()
}

// Elasticsearch写入
func (*_Elasticsearch) Update(title, content string, ID int) {
	BodyStr := Json.Marshal(Body{
		Title:   title,
		Content: content,
	})
	req := esapi.IndexRequest{
		DocumentType: "_doc",
		Index:        "blogo",
		DocumentID:   strconv.Itoa(ID),
		Body:         strings.NewReader(BodyStr),
		Refresh:      "true",
	}
	res, err := req.Do(context.Background(), ES)
	if err != nil {
		log.Panic("Elasticsearch插入失败:", err)
	}
	defer res.Body.Close()
}

// Elaticsearch全文搜索
func (*_Elasticsearch) Search(keyword string) string {
	req := esapi.SearchRequest{
		Index: []string{"blogo"},
		Body: strings.NewReader(`{
			"query": {
    			"multi_match": {
      				"query": "` + keyword + `",
      				"fields": [
        					"content",
        					"title"
      				],
      				"analyzer": "ik_smart"
				}
  			},
  			"highlight": {
				"fields": {
					"title": {
					},
					"content": {
					}
				},
				"pre_tags": [
					"<font color='#F3434'>"
				],
				"post_tags": [
					"</font>"
				],
				"fragment_size": 300
			}
		}`),
		DocumentType: []string{"_doc"},
	}
	res, err := req.Do(ctx, ES)
	if err != nil {
		log.Panic("Elasticsearch搜索失败:", err)
	}
	SearchResult, _ := io.ReadAll(res.Body)
	//log.Println(string(SearchResult[:]))
	defer res.Body.Close()
	return string(SearchResult[:])
}
