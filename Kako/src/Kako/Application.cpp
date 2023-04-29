#include "hzpch.h"
#include "Application.h"
#include"Events/ApplicationEvent.h"
#include"Log.h"

namespace Kako {
	Application::Application()
	{
	}
	Application::~Application()
	{
	}
	void Application::Run()
	{
		WindowResizeEvent e(720,720);
		HZ_TRACE(e);
		while (true);
	}
}
