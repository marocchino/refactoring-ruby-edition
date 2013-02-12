is_mac_os = platform.upcase.index("MAC")
is_ie_browser = browser.upcase.index("IE")
was_resized = resize > 0
end
if (is_mac_os && is_ie_browser && initialized? && was_resized)
  # 기타 작업
end
