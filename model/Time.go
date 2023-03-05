package model

import (
	"database/sql/driver"
	"time"
)

type FormatTime struct {
	time.Time
}

func (f FormatTime) MarshalJSON() ([]byte, error) {
	formated := f.Format("2006-01-02 15:04:05")
	return []byte(`"` + formated + `"`), nil
}

func (f FormatTime) Value() (driver.Value, error) {
	var zeroTime time.Time
	if f.Time.UnixNano() == zeroTime.UnixNano() {
		return nil, nil
	}
	return f.Time, nil
}

func (f *FormatTime) Scan(v interface{}) error {
	value, ok := v.(time.Time)
	if ok {
		*f = FormatTime{Time: value}
		return nil
	}
	return nil
}

type ArticleTime struct {
	time.Time
}

func (f ArticleTime) MarshalJSON() ([]byte, error) {
	formated := f.Format("2006-01-02")
	return []byte(`"` + formated + `"`), nil
}

func (f ArticleTime) Value() (driver.Value, error) {
	var zeroTime time.Time
	if f.Time.UnixNano() == zeroTime.UnixNano() {
		return nil, nil
	}
	return f.Time, nil
}

func (f *ArticleTime) Scan(v interface{}) error {
	value, ok := v.(time.Time)
	if ok {
		*f = ArticleTime{Time: value}
		return nil
	}
	return nil
}
