#include "hzpch.h"
#include "RenderCommand.h"

#include "Platform/OpenGL/OpenGLRendererAPI.h"

namespace Kako {

	RendererAPI* RenderCommand::s_RendererAPI = new OpenGLRendererAPI;

}