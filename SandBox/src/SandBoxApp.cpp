#include<Kako.h>

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
			PushOverlay(new Kako::ImGuiLayer());
        }
        ~SandBox() {

        }
};
Kako::Application* Kako::CreateApplication() {
    return new SandBox();
}