function platform_defines()
    filter {"configurations:Debug or Release"}
        defines{"PLATFORM_DESKTOP"}

    filter {"configurations:Debug_RGFW or Release_RGFW"}
        defines{"PLATFORM_DESKTOP_RGFW"}

    filter {"options:graphics=opengl43"}
        defines{"GRAPHICS_API_OPENGL_43"}

    filter {"options:graphics=opengl33"}
        defines{"GRAPHICS_API_OPENGL_33"}

    filter {"options:graphics=opengl21"}
        defines{"GRAPHICS_API_OPENGL_21"}

    filter {"options:graphics=opengl11"}
        defines{"GRAPHICS_API_OPENGL_11"}

    filter {"options:graphics=openges3"}
        defines{"GRAPHICS_API_OPENGL_ES3"}

    filter {"options:graphics=openges2"}
        defines{"GRAPHICS_API_OPENGL_ES2"}

    filter {"system:macosx"}
        disablewarnings {"deprecated-declarations"}

    filter {"system:linux"}
        defines {"_GLFW_X11"}
        defines {"_GNU_SOURCE"}

    filter{}
end

local raylib_dir = path.getabsolute(".")

project "raylib"
    kind "StaticLib"

    platform_defines()

     location "build_files/"

     language "C"
     
    targetdir ("bin/%{cfg.buildcfg}")
    objdir ("bin-int/%{cfg.buildcfg}")

    filter { "system:linux or system:macosx" }
        pic "On"

     filter "action:vs*"
        defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS"}
        characterset ("Unicode")
        buildoptions { "/Zc:__cplusplus" }
    filter{}

     includedirs {raylib_dir .. "/src", raylib_dir .. "/src/external/glfw/include" }
    vpaths
    {
        ["Header Files"] = { raylib_dir .. "/src/**.h"},
        ["Source Files/*"] = { raylib_dir .. "/src/**.c"},
    }
    files {raylib_dir .. "/src/*.h", raylib_dir .. "/src/*.c"}

     removefiles {raylib_dir .. "/src/rcore_*.c"}

     filter { "system:macosx", "files:" .. raylib_dir .. "/src/rglfw.c" }
        compileas "Objective-C"

     filter{}
