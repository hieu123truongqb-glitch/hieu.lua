using UnityEngine;

public class SkyboxChanger : MonoBehaviour
{
    // Kéo và thả kết cấu skybox equirectangular của bạn vào đây trong Trình kiểm tra
    public Texture2D skyboxTexture;

    // Kéo và thả Vật liệu Skybox của bạn vào đây (Sử dụng shader "Skybox/Cubemap" hoặc tương tự)
    public Material skyboxMaterial;

    // Các biến để kiểm soát độ phơi sáng và màu sắc
    public float exposure = 1.0f;
    public Color tint = Color.white;

    void Start()
    {
        // Khi bắt đầu, hãy áp dụng các cài đặt skybox
        ApplySkyboxSettings();
    }

    // Bạn có thể gọi hàm này từ bất cứ đâu để thay đổi skybox
    public void SetNewSkybox(Texture2D newTexture)
    {
        if (newTexture != null)
        {
            skyboxTexture = newTexture;
            ApplySkyboxSettings();
        }
    }

    // Hàm áp dụng các cài đặt cho vật liệu skybox và hệ thống
    void ApplySkyboxSettings()
    {
        if (skyboxMaterial == null || skyboxTexture == null)
        {
            Debug.LogError("Skybox material or texture is not assigned!");
            return;
        }

        // Thiết lập kết cấu cho vật liệu
        // Tùy thuộc vào shader bạn sử dụng, tên thuộc tính kết cấu có thể khác nhau.
        // Thông thường, nó là "_MainTex", "_Tex", hoặc "_Cubemap" cho các shader cubemap.
        skyboxMaterial.SetTexture("_Tex", skyboxTexture);

        // Thiết lập các thuộc tính khác (nếu shader hỗ trợ)
        skyboxMaterial.SetFloat("_Exposure", exposure);
        skyboxMaterial.SetColor("_Tint", tint);

        // Gán vật liệu skybox làm render setting cho cảnh
        RenderSettings.skybox = skyboxMaterial;

        // Bắt buộc làm mới skybox (đôi khi cần thiết)
        DynamicGI.UpdateEnvironment();
    }

    // (Tùy chọn) Một ví dụ về cách thay đổi skybox khi nhấn một phím
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.K))
        {
            // Set a new tint, like a blood moon
            tint = Color.red;
            exposure = 1.5f;
            ApplySkyboxSettings();
        }
    }
      }
      
