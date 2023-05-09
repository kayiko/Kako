workspace "Kako" --解决方案名称
    architecture "x86_64" --编译平台 只编64位--(x86,x86_64,ARM)
    startproject "Sandbox"

    configurations 
    {
        "Debug",
        "Release",
        "Dist"
    }
--临时变量 定义 输出目录
--详细的所有支持的tokens 可参考 [https://github.com/premake/premake-core/wiki/Tokens]
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

include "Kako/vendor/GLFW"
include "Kako/vendor/Glad"
include "Kako/vendor/imgui"


IncludeDir = {}
IncludeDir["GLFW"] = "Kako/vendor/GLFW/include"
IncludeDir["Glad"] = "Kako/vendor/Glad/include"
IncludeDir["ImGui"] = "Kako/vendor/imgui"
IncludeDir["glm"] = "Kako/vendor/glm"



project "Kako" --项目名称
    location "Kako" --相对路径
    kind "StaticLib" --表明该项目是dll动态库
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")--输出目录
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")--中间临时文件的目录

    pchheader "hzpch.h"
    pchsource "Kako/src/hzpch.cpp"

    files--该项目的文件
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
    includedirs--附加包含目录
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
    

    filter "system:windows"--windows平台的配置
        systemversion "latest"

        defines --预编译宏
        {
            "HZ_BUILD_DLL",
            "HZ_PLATFORM_WINDOWS",
            "_WINDLL",
            "_UNICODE",
            "UNICODE",
            "GLFW_INCLUDE_NONE"
        }

        postbuildcommands -- build后的自定义命令
        {
            --("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox") --拷贝引擎dll库到sanbox.exe的同一目录下去
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
