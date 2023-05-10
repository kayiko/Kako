#include<Kako.h>
#include "imgui/imgui.h"
class ExampleLayer : public Kako::Layer
{
public:
	ExampleLayer()
		: Layer("Example")
	{
	}

	void OnUpdate() override
	{
		if(Kako::Input::IsKeyPressed(HZ_KEY_TAB))
		HZ_TRACE("Tab key is pressed!");
	}
	virtual void OnImGuiRender() override
	{
		//ImGui::Begin();

		ImGui::Begin("Test");
		ImGui::Text("Hello World");

		ImGui::End();
	}

	void OnEvent(Kako::Event& event) override
	{
		if (event.GetEventType() == Kako::EventType::KeyPressed)
		{
			Kako::KeyPressedEvent& e = (Kako::KeyPressedEvent&)event;
			if (e.GetKeyCode() == HZ_KEY_TAB)
				HZ_TRACE("Tab key is pressed (event)!");
			HZ_TRACE("{0}", (char)e.GetKeyCode());
		}
	}

};

class SandBox : public Kako::Application {
    public:
        SandBox() {
			PushLayer(new ExampleLayer());
			
        }
        ~SandBox() {

        }
};
Kako::Application* Kako::CreateApplication() {
    return new SandBox();
}