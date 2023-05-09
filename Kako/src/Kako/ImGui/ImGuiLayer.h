#pragma once
#include "Kako/Events/ApplicationEvent.h"
#include "Kako/Events/KeyEvent.h"
#include "Kako/Events/MouseEvent.h"
#include "Kako/Layer.h"

namespace Kako {

	class HAZEL_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnImGuiRender() override;

		void Begin();
		void End();
	private:
		float m_Time = 0.0f;
	};

}