#pragma once
#include "Core.h"

#include "Window.h"
#include "Kako/LayerStack.h"
#include "Kako/Events/Event.h"
#include "Kako/Events/ApplicationEvent.h"

#include "Kako/ImGui/ImGuiLayer.h"
#include "Kako/Core/Timestep.h"

namespace Kako {
    class HAZEL_API Application
    {
        public:
            Application();
            virtual~Application();
            void Run();
            void OnEvent(Event& e);
            void PushLayer(Layer* layer);
            void PushOverlay(Layer* layer);
            inline Window& GetWindow() { return *m_Window; }

            inline static Application& Get() { return *s_Instance; }
        private:
            bool OnWindowClose(WindowCloseEvent& e);
            std::unique_ptr<Window> m_Window;
            ImGuiLayer* m_ImGuiLayer;
            bool m_Running = true;
            LayerStack m_LayerStack;
            static Application* s_Instance;
            float m_LastFrameTime = 0.0f;

    };
    Application* CreateApplication();
}


