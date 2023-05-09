workspace "Kako" --�����������
    architecture "x86_64" --����ƽ̨ ֻ��64λ--(x86,x86_64,ARM)
    startproject "Sandbox"

    configurations 
    {
        "Debug",
        "Release",
        "Dist"
    }
--��ʱ���� ���� ���Ŀ¼
--��ϸ������֧�ֵ�tokens �ɲο� [https://github.com/premake/premake-core/wiki/Tokens]
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

include "Kako/vendor/GLFW"
include "Kako/vendor/Glad"
include "Kako/vendor/imgui"


IncludeDir = {}
IncludeDir["GLFW"] = "Kako/vendor/GLFW/include"
IncludeDir["Glad"] = "Kako/vendor/Glad/include"
IncludeDir["ImGui"] = "Kako/vendor/imgui"
IncludeDir["glm"] = "Kako/vendor/glm"



project "Kako" --��Ŀ����
    location "Kako" --���·��
    kind "StaticLib" --��������Ŀ��dll��̬��
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")--���Ŀ¼
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")--�м���ʱ�ļ���Ŀ¼

    pchheader "hzpch.h"
    pchsource "Kako/src/hzpch.cpp"

    files--����Ŀ���ļ�
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/vendor/glm/glm/**.hpp",
        "%{prj.name}/vendor/glm/glm/**.inl"
    }
    defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}
    includedirs--���Ӱ���Ŀ¼
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}"
    }
    links
    {
        "GLFW",
        "Glad",
        "ImGui",
        "opengl32.lib"
    }
    

    filter "system:windows"--windowsƽ̨������
        systemversion "latest"

        defines --Ԥ�����
        {
            "HZ_BUILD_DLL",
            "HZ_PLATFORM_WINDOWS",
            "_WINDLL",
            "_UNICODE",
            "UNICODE",
            "GLFW_INCLUDE_NONE"
        }

        postbuildcommands -- build����Զ�������
        {
            --("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox") --��������dll�⵽sanbox.exe��ͬһĿ¼��ȥ
            ("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "HZ_DIST"
        
        runtime "Release"
        optimize "on"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
	staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "Kako/vendor/spdlog/include",
        "Kako/src",
        "Kako/vendor",
        "%{IncludeDir.glm}"
    }

    links
    {
        "Kako"
    }

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "_UNICODE",
            "UNICODE",
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "HZ_DIST"
        runtime "Release"
        optimize "on"
