#pragma once
#ifdef HZ_PLATFORM_WINDOWS

extern Kako::Application* Kako:: CreateApplication();

int main(int argc, char** argv) {
	Kako::Log::Init();
	// 原本代码输出日志
	Kako::Log::GetCoreLogger()->warn("原始代码输出日志");
	Kako::Log::GetClientLogger()->error("原始代码输出日志");

	// 用宏定义，输出日志
	HZ_CORE_WARN("Initialized Log!");
	int a = 5;
	HZ_INFO("Hello! Var={0}", a);

	auto app = Kako::CreateApplication();
	app->Run();
	delete app;

}

#endif
