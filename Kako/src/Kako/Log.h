#pragma once


#include"Core.h"
#include "spdlog/spdlog.h"
#include"spdlog/fmt/ostr.h"

namespace Kako {
    class HAZEL_API Log
    {
    public:
      static void Init();
      inline static std::shared_ptr<spdlog::logger>& GetCoreLogger(){return s_CoreLogger;}
      inline static std::shared_ptr<spdlog::logger>& GetClientLogger(){return s_ClientLogger;}
    private:
        static std::shared_ptr<spdlog::logger> s_CoreLogger;// Hazel项目的日志对象
        static std::shared_ptr<spdlog::logger> s_ClientLogger;// Sandbox项目的日志对象
        
    };
}
#define HZ_CORE_TRACE(...)    ::Kako::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define HZ_CORE_INFO(...)     ::Kako::Log::GetCoreLogger()->info(__VA_ARGS__)
#define HZ_CORE_WARN(...)     ::Kako::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define HZ_CORE_ERROR(...)    ::Kako::Log::GetCoreLogger()->error(__VA_ARGS__)
#define HZ_CORE_FATAL(...)    ::Kako::Log::GetCoreLogger()->critical(__VA_ARGS__)

// Client log macros
#define HZ_TRACE(...)	      ::Kako::Log::GetClientLogger()->trace(__VA_ARGS__)
#define HZ_INFO(...)	      ::Kako::Log::GetClientLogger()->info(__VA_ARGS__)
#define HZ_WARN(...)	      ::Kako::Log::GetClientLogger()->warn(__VA_ARGS__)
#define HZ_ERROR(...)	      ::Kako::Log::GetClientLogger()->error(__VA_ARGS__)
#define HZ_FATAL(...)	      ::Kako::Log::GetClientLogger()->critical(__VA_ARGS__)


