# DepthSense
Auditory Aid for the Visually Impaired

About DeepSense

Introducing DepthSense: Auditory Aid for the Visually Impaired
DepthSense is an innovative mobile application designed to provide invaluable auditory assistance for individuals with visual impairments. Leveraging advanced camera lidar technology, this app generates a detailed depth map and converts it into a unique soundscape where the frequency of sound corresponds to the distance between objects and the center of the device screen.
Features:

Depth Mapping: Utilizing the power of camera lidar, DepthSense quickly captures the surroundings and creates a comprehensive depth map in real time. This enables users to perceive their environment by sound.

Auditory Feedback: The app transforms the depth information into a rich soundscape. As the user moves or interacts with objects, they will hear varying frequencies that represent different distances. This auditory feedback allows for an enhanced understanding of the spatial layout, enabling users to navigate their surroundings more confidently.

Instant Sound Activation: Upon launching the app, DepthSense will immediately start generating the auditory feedback. This ensures users can rely on it as soon as it is opened, without any additional steps or delays.

Pause and Play Functionality: With a simple tap on the screen, users can pause the generated sound. This feature comes in handy during conversations or when temporarily focusing on other activities. Another tap will resume the sound, allowing users to effortlessly toggle between auditory feedback and silence as needed.

User-Friendly Interface: DepthSense features an intuitive and accessible user interface, making it easy for individuals with visual impairments to navigate and interact with the app. The interface focuses on simplicity and prioritizes a seamless user experience.
Whether you're exploring a new environment, maneuvering through familiar spaces, or engaging in daily activities, DepthSense is your reliable auditory companion, helping you perceive and understand your surroundings in a whole new way.

Please note: DepthSense is designed as a supplementary tool and should not replace any existing mobility aids or techniques employed by visually impaired individuals.

How to use:
Once you start the app for the first time you need to give permission for the app to use camera as LIDAR is part of the camera. There are no other settings or tabs that need to be accessed in order for app to work. Sound with frequency that corresponds to distance from phone to the object in the center in the camera field with start automatically. In order to pause sound and toggle it ON and OFF tap anywhere on phone screen. For the simplicity and accessibility purposes that is the only function that is implemented at the moment.
I would like to hear your comments how to improve the app.

Please send comments to FarWatchPost@gmail.com

Click on the image bellow to view short description video:

[![DepthSense](https://github.com/Berranzan/DepthSense/blob/main/docs/assets/DepthSense%20screenshot%20small.png?raw=true)](https://www.youtube.com/watch?v=hSlkyQm20xM "DepthSense")

About code:
When some time ago I learned that iPhones have LIDAR this kind of app was one of the first things that pop up in my mind. I was surprised that no one even tried to implement it, at least that I know of.
Code is canibalized/frankensteinized from this article and provided code: https://developer.apple.com/documentation/arkit/environmental_analysis/displaying_a_point_cloud_using_scene_depth
Function to get pixel color at the center of the screen is added in ARDataProvider class:
 func GetColor () -> CGFloat?{
        guard let _ = depthContent.texture else {return 0.0}
        let x = depthContent.texture!.width/2
        let y = depthContent.texture!.height/2
        let pixels: UnsafeMutablePointer<Float32> = depthContent.texture!.getPixels(MTLRegionMake2D(x, y, 1, 1), mipmapLevel: 0)
        defer {
          pixels.deallocate()
        }
        let red: CGFloat   = CGFloat(pixels[2])
        let green: CGFloat = CGFloat(pixels[1])
        let blue: CGFloat  = CGFloat(pixels[0])
        var alpha: CGFloat = CGFloat(pixels[3])
        var white: CGFloat = 0
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        color.getWhite(&white, alpha: &alpha)
        
        return white
    }
  ToneOutputUnit was taken from this article: https://stackoverflow.com/questions/55572894/produce-sounds-of-different-frequencies-in-swift
  But upon some examination I have realized that it is part of this project: https://gist.github.com/hotpaw2/630a466cc830e3d129b9
  Credit and thanks to https://gist.github.com/hotpaw2 for writing so usefull code.
