package utils

import (
	"Blogo/config"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
	"log"
	"os"
	"time"
)

// 全局日志指针
var Logger *zap.Logger

func InitLogger() {
	// 日志文件目录
	if ok, _ := PathExist(config.Cfg.Zap.Directory); !ok {
		log.Printf("create %v directory\n", config.Cfg.Zap.Directory)
		_ = os.Mkdir(config.Cfg.Zap.Directory, os.ModePerm)
	}
	core := zapcore.NewCore(getEncoder(), getWriterSyncer(), getLevelPriority())
	Logger = zap.New(core)

	if config.Cfg.Zap.ShowLine {
		// 获取调用的文件名和函数名
		Logger = Logger.WithOptions(zap.AddCaller())
	}

	log.Println("Zap Logger 初始化成功！")
}

// 编码器：如何写入日志
func getEncoder() zapcore.Encoder {
	encoderConfig := zapcore.EncoderConfig{
		MessageKey:     "message",
		LevelKey:       "level",
		TimeKey:        "time",
		NameKey:        "logger",
		CallerKey:      "caller",
		StacktraceKey:  "stacktrace",
		LineEnding:     zapcore.DefaultLineEnding,
		EncodeLevel:    zapcore.CapitalLevelEncoder,
		EncodeTime:     customTimeEncoder,
		EncodeDuration: zapcore.SecondsDurationEncoder,
		EncodeCaller:   zapcore.FullCallerEncoder,
	}

	if config.Cfg.Zap.Format == "json" {
		return zapcore.NewConsoleEncoder(encoderConfig)
	}
	return zapcore.NewConsoleEncoder(encoderConfig)

}

// 日志输出路径:文件、控制台、双向输出
func getWriterSyncer() zapcore.WriteSyncer {
	file, _ := os.Create(config.Cfg.Zap.Directory + "/log.log")

	// 双向输出
	if config.Cfg.Zap.LogInConsole {
		fileWriter := zapcore.AddSync(file)
		consoleWriter := zapcore.AddSync(os.Stdout)
		return zapcore.NewMultiWriteSyncer(fileWriter, consoleWriter)
	}

	// 输出到文件
	return zapcore.AddSync(file)
}

// 获取日志输出级别
func getLevelPriority() zapcore.LevelEnabler {
	switch config.Cfg.Zap.Level {
	case "debug", "Debug":
		return zap.DebugLevel
	case "info", "Info":
		return zap.InfoLevel
	case "warn", "Warn":
		return zap.WarnLevel
	case "error", "Error":
		return zap.ErrorLevel
	case "dpanic", "DPanic":
		return zap.DPanicLevel
	case "panic", "Panic":
		return zap.PanicLevel
	case "fatal", "Fatal":
		return zap.FatalLevel
	default:
		return zap.InfoLevel
	}
}

// 自定义日志输出时间格式
func customTimeEncoder(t time.Time, encoder zapcore.PrimitiveArrayEncoder) {
	encoder.AppendString(config.Cfg.Zap.Prefix + t.Format("2006/01/02 - 15:04:05"))
}
