#pragma once
#include "Core.h"
#include"Events/Event.h"
namespace Kako {
    class HAZEL_API Application
    {
        public:
            Application();
            virtual~Application();
            void Run();
    };
    Application* CreateApplication();
}


