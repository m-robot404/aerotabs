import Testing
@testable import AeroTabs

@Suite("AeroSpaceClient")
struct AeroSpaceClientTests {
    @Test("parses window list")
    func parseWindowList() {
        let output = "1|Finder|com.apple.finder\n2|Safari|com.apple.Safari\n"
        let windows = AeroSpaceClient.parseWindowList(output)
        #expect(windows.count == 2)
        #expect(windows[0].windowId == "1")
        #expect(windows[0].appName == "Finder")
        #expect(windows[0].bundleId == "com.apple.finder")
    }

    @Test("ignores malformed window lines")
    func ignoresMalformedLines() {
        let output = "1|Finder|com.apple.finder\ninvalid\n"
        #expect(AeroSpaceClient.parseWindowList(output).count == 1)
    }

    @Test("parses focused window id")
    func parseFocusedWindowId() {
        #expect(AeroSpaceClient.parseFocusedWindowId("42\n") == "42")
        #expect(AeroSpaceClient.parseFocusedWindowId("") == nil)
    }

    @Test("parses focused workspace name")
    func parseFocusedWorkspaceName() {
        #expect(AeroSpaceClient.parseFocusedWorkspaceName("3\n") == "3")
        #expect(AeroSpaceClient.parseFocusedWorkspaceName("  A  \n") == "A")
        #expect(AeroSpaceClient.parseFocusedWorkspaceName("") == nil)
    }
}
