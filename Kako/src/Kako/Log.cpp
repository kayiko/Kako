#include "hzpch.h"
#include "Log.h"

#include "spdlog/sinks/stdout_color_sinks.h"
namespace Kako {
	std::shared_ptr<spdlog::logger> Log::s_CoreLogger;
	std::shared_ptr<spdlog::logger> Log::s_ClientLogger;
	void Log::Init()
	{
		// 自定义日志格式：%^颜色起始点、%T时间戳(HH:MM:SS)、%n记录员的名字、%v实际的文本、%$颜色结束点
		spdlog::set_pattern("%^[%T] %n: %v%$");
		s_CoreLogger = spdlog::stdout_color_mt("Kako");// HAZEL 对应自定义格式的%n
		s_CoreLogger->set_level(spdlog::level::trace);

		s_ClientLogger = spdlog::stdout_color_mt("SandBox");// APP 对应自定义格式的%n
		s_ClientLogger->set_level(spdlog::level::trace);
	}

}
