#pragma once
#ifdef HZ_PLATFORM_WINDOWS

extern Kako::Application* Kako:: CreateApplication();

int main(int argc, char** argv) {
printf("Kako");
    auto app = Kako::CreateApplication();
    app->Run();
    delete app;
}

#endif
