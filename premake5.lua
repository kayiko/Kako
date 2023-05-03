workspace "Kako" --�����������
    architecture "x86_64" --����ƽ̨ ֻ��64λ--(x86,x86_64,ARM)

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
IncludeDir = {}
IncludeDir["GLFW"] = "Kako/vendor/GLFW/include"

project "Kako" --��Ŀ����
    location "Kako" --���·��
    kind "SharedLib" --��������Ŀ��dll��̬��
    language "c++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")--���Ŀ¼
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")--�м���ʱ�ļ���Ŀ¼

    pchheader "hzpch.h"
    pchsource "Kako/src/hzpch.cpp"

    files--����Ŀ���ļ�
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs--���Ӱ���Ŀ¼
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}"
    }
    links
    {
        "GLFW",
        "opengl32.lib"
    }
    

    filter "system:windows"--windowsƽ̨������
        cppdialect "c++17"
        staticruntime "On"
        systemversion "latest"

        defines --Ԥ�����
        {
            "HZ_BUILD_DLL",
            "HZ_PLATFORM_WINDOWS",
            "_WINDLL",
            "_UNICODE",
            "UNICODE",
        }

        postbuildcommands -- build����Զ�������
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox") --��������dll�⵽sanbox.exe��ͬһĿ¼��ȥ
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        buildoptions "/MDd"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        buildoptions "/MD"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "HZ_DIST"
        buildoptions "/MD"
        runtime "Release"
        optimize "on"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

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
        "Kako/src"
    }

    links
    {
        "Kako"
    }

    filter "system:windows"
        cppdialect "c++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "_UNICODE",
            "UNICODE",
        }

    filter "configurations:Debug"
        defines "HZ_DEBUG"
        buildoptions "/MDd"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        defines "HZ_RELEASE"
        buildoptions "/MD"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        defines "HZ_DIST"
        buildoptions "/MD"
        runtime "Release"
        optimize "on"
