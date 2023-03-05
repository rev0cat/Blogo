package utils

import (
	"Blogo/config"
	"context"
	"github.com/go-redis/redis/v9"
	"go.uber.org/zap"
	"log"
	"time"
)

const RedisUtilErrPrefix = "utils/Redis.go -> "

var (
	ctx = context.Background()
	Rdb *redis.Client
)

// 对Redis库的二次操作封装，统一处理错误
var Redis = new(_redis)

type _redis struct{}

// 初始化Redis连接
func InitRedis() *redis.Client {
	cfg := config.Cfg.Redis
	Rdb = redis.NewClient(&redis.Options{
		Addr:     cfg.Addr,
		Password: cfg.Password,
		DB:       cfg.DB,
	})
	// 测试连接
	_, err := Rdb.Ping(ctx).Result()
	if err != nil {
		log.Panic("Redis连接失败:", err)
	}
	log.Println("Redis连接成功！")
	return Rdb
}

// 通用指令执行方法
// func (*redisUtil) Execute(cmd string, args ...any) (any, error) {
// 	return rdb.Do(ctx, args...).Result()
// }

// Redis根据匹配项获取键名列表
func (*_redis) Keys(pattern string) []string {
	return Rdb.Keys(ctx, pattern).Val()
}

// Redis删除值
func (*_redis) Del(key string) {
	err := Rdb.Del(ctx, key).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"Del:", zap.Error(err))
		panic(err)
	}
}

// Redis设置过期时间
func (*_redis) Set(key string, value interface{}, expire time.Duration) {
	err := Rdb.Set(ctx, key, value, expire).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"Set:", zap.Error(err))
		panic(err)
	}
}

// Key值自增，若Key不存在则初始化为零再自增
func (*_redis) Incr(key string) {
	err := Rdb.Incr(ctx, key).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"Incr:", zap.Error(err))
		panic(err)
	}
}

// Key值自增特定值，若Key不存在则初始化为零再自增
func (*_redis) IncrBy(key string, incr int64) {
	err := Rdb.IncrBy(ctx, key, incr).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"IncrBy:", zap.Error(err))
		panic(err)
	}
}

// Redis取数字
func (*_redis) GetInt(key string) int {
	val, _ := Rdb.Get(ctx, key).Int()
	return val
}

// Redis取值
func (*_redis) GetValue(key string) string {
	return Rdb.Get(ctx, key).Val()
}

func (*_redis) GetResult(key string) (string, error) {
	return Rdb.Get(ctx, key).Result()
}

// 往集合Set中添加元素
func (*_redis) SAdd(key string, members ...any) {
	err := Rdb.SAdd(ctx, key, members...).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"SAdd:", zap.Error(err))
		panic(err)
	}
}

// 判断元素是否是Set的成员
func (*_redis) SIsMember(key string, member any) bool {
	return Rdb.SIsMember(ctx, key, member).Val()
}

// 获取Set成员列表
func (*_redis) SMembers(key string) []string {
	return Rdb.SMembers(ctx, key).Val()
}

// 移除Set中的元素
func (*_redis) SRem(key string, member any) {
	Rdb.SRem(ctx, key, member)
}

// 为哈希表中的字段值加上特定增量(可负)
// key不存在自动创建哈希表
// 如果 field 不存在, 创建该字段值并初始化为 0
func (*_redis) HIncrBy(key, field string, incr int64) {
	err := Rdb.HIncrBy(ctx, key, field, incr).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"HIncrBy:", zap.Error(err))
		panic(err)
	}
}

// 设置哈希表值
func (*_redis) HSet(key string, value map[string]string) {
	err := Rdb.HSet(ctx, key, value).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"HSet:", zap.Error(err))
		panic(err)
	}
}

// 获取哈希表指定字段的值
func (*_redis) HGet(key, field string) int {
	val, _ := Rdb.HGet(ctx, key, field).Int()
	return val
}

// 获取哈希表所有字段和值
func (*_redis) HGetAll(key string) map[string]string {
	return Rdb.HGetAll(ctx, key).Val()
}

func (*_redis) ZRangeWithScores(key string, start, stop int64) []redis.Z {
	return Rdb.ZRangeWithScores(ctx, key, start, stop).Val()
}

// 获取有序集合中成员的分数值
func (*_redis) ZScore(key, member string) int {
	return int(Rdb.ZScore(ctx, key, member).Val())
}

// 有序集合中Key指定字段整数值加上增量
func (*_redis) ZIncrBy(key, member string, incr float64) {
	err := Rdb.ZIncrBy(ctx, key, incr, member).Err()
	if err != nil {
		Logger.Error(RedisUtilErrPrefix+"ZIncrBy:", zap.Error(err))
		panic(err)
	}
}

// 统计有序集合的元素个数
func (*_redis) ZCount(key string) int {
	res := Rdb.ZCount(ctx, key, "0", "1000")
	if res.Err() != nil {
		Logger.Error(RedisUtilErrPrefix+"ZCount:", zap.Error(res.Err()))
		panic(res.Err())
	}
	return int(res.Val())
}

// 有序集合中添加元素
func (*_redis) ZAdd(key, member string, score float64) {
	Rdb.ZAdd(ctx, key, redis.Z{Member: member, Score: score})
}

//func (*_redis) ZGet(key string) {
//	return Rdb.Z
//}

// List中添加元素
func (*_redis) LAdd(key string, member any) {
	Rdb.LRem(ctx, key, 1, member)
	Rdb.LPush(ctx, key, member)
	Rdb.LTrim(ctx, key, 0, 6)
	Rdb.Expire(ctx, key, time.Hour*24*30)
}

// List中获取元素
func (*_redis) LGet(key string) []string {
	list := Rdb.LRange(ctx, key, 0, -1)
	return list.Val()
}

// List中删除元素
func (*_redis) LDelete(key string, member int) {
	Rdb.LRem(ctx, key, 1, member)
}

// 清空List
func (*_redis) LClean(key string) {
	Rdb.LTrim(ctx, key, 1, 0)
}
