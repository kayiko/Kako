#pragma once
#ifdef HZ_PLATFORM_WINDOWS

extern Kako::Application* Kako:: CreateApplication();

int main(int argc, char** argv) {
	Kako::Log::Init();
	// ԭ�����������־
	Kako::Log::GetCoreLogger()->warn("ԭʼ���������־");
	Kako::Log::GetClientLogger()->error("ԭʼ���������־");

	// �ú궨�壬�����־
	HZ_CORE_WARN("Initialized Log!");
	int a = 5;
	HZ_INFO("Hello! Var={0}", a);

	auto app = Kako::CreateApplication();
	app->Run();
	delete app;

}

#endif
