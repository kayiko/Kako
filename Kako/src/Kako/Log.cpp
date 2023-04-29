#include "hzpch.h"
#include "Log.h"

#include "spdlog/sinks/stdout_color_sinks.h"
namespace Kako {
	std::shared_ptr<spdlog::logger> Log::s_CoreLogger;
	std::shared_ptr<spdlog::logger> Log::s_ClientLogger;
	void Log::Init()
	{
		// �Զ�����־��ʽ��%^��ɫ��ʼ�㡢%Tʱ���(HH:MM:SS)��%n��¼Ա�����֡�%vʵ�ʵ��ı���%$��ɫ������
		spdlog::set_pattern("%^[%T] %n: %v%$");
		s_CoreLogger = spdlog::stdout_color_mt("Kako");// HAZEL ��Ӧ�Զ����ʽ��%n
		s_CoreLogger->set_level(spdlog::level::trace);

		s_ClientLogger = spdlog::stdout_color_mt("SandBox");// APP ��Ӧ�Զ����ʽ��%n
		s_ClientLogger->set_level(spdlog::level::trace);
	}

}
