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
		HZ_INFO("ExampleLayer::Update");
	}

	void OnEvent(Kako::Event& event) override
	{
		HZ_TRACE("{0}", event);
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