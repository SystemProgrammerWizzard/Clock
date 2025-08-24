cmake_minimum_required(VERSION 3.16)
project(Clock LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2)

# ECM is still useful for KDE helpers/macros
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

# Find KF5 components directly
find_package(KF5Kirigami2   REQUIRED)
find_package(KF5I18n        REQUIRED)
find_package(KF5Config      REQUIRED)
find_package(KF5CoreAddons  REQUIRED)

add_executable(clock
    src/main.cpp
    qml.qrc
)

target_link_libraries(clock PRIVATE
    Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick Qt5::QuickControls2
    KF5::Kirigami2 KF5::I18n KF5::ConfigCore KF5::CoreAddons
)