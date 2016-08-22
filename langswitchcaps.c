#define _WIN32_WINNT 0x0501
//#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <tchar.h>

HHOOK   g_khook;
HANDLE  g_hEvent;
//UINT    g_key = VK_RCONTROL;
const UINT    g_key = VK_CAPITAL;
//91 (0x5B) - VK_LWIN (Left Windows)
//20 (0x14) - VK_CAPITAL (Caps Lock)
//93 (0x5D) - VK_APPS (Application key)
//#define VK_RCONTROL 163 (0xA3)

LRESULT CALLBACK KbdHook(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode < 0)
    {
        return CallNextHookEx(g_khook, nCode, wParam, lParam);
    }
    if (nCode == HC_ACTION)
    {
        KBDLLHOOKSTRUCT*   ks = (KBDLLHOOKSTRUCT*)lParam;
        if (ks -> vkCode == g_key)
        {
            if (wParam == WM_KEYDOWN)
            {
                HWND hWnd = GetForegroundWindow();
                HWND hWnd_thread = 0;
                AttachThreadInput(GetCurrentThreadId(), GetWindowThreadProcessId(hWnd, NULL), TRUE);
                hWnd_thread = GetFocus();
                if (hWnd_thread)
                {
                    hWnd = hWnd_thread;
                }
                if (hWnd)
                {
                    PostMessage(hWnd, WM_INPUTLANGCHANGEREQUEST, 0, (LPARAM)HKL_NEXT);
                }
            }
            return 1;
        }
    }
skip:
    return CallNextHookEx(g_khook, nCode, wParam, lParam);
}

void CALLBACK TimerCb(HWND hWnd, UINT uMsg, UINT_PTR idEvent, DWORD dwTime)
{
    if (WaitForSingleObject(g_hEvent, 0) == WAIT_OBJECT_0)
    {
        PostQuitMessage(0);
    }
}

void failed(const TCHAR* msg)
{
    MessageBox(NULL, msg, _T("Error"), MB_OK | MB_ICONERROR);
    ExitProcess(1);
}

//int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
int main()
{
    MSG     msg;
    DWORD   sz;
    BOOL    fQuit = FALSE;
    LPWSTR*  argv;
    int     argc = 0;
    int     cmdKey = 0;

    g_hEvent = CreateEvent(NULL, TRUE, FALSE, _T("LangSwitchCaps"));
    if (g_hEvent == NULL)
    {
        failed(_T("CreateEvent()"));
    }
    if (GetLastError() == ERROR_ALREADY_EXISTS)
    {
        fQuit = TRUE;
        SetEvent(g_hEvent);
        goto quit;
    }

    if (SetTimer(NULL, 0, 500, TimerCb) == 0)
    {
        failed(_T("SetTimer()"));
    }

    g_khook = SetWindowsHookEx(WH_KEYBOARD_LL, KbdHook, GetModuleHandle(0), 0);
    if (g_khook == 0)
    {
        failed(_T("SetWindowsHookEx()"));
    }

    while (GetMessage(&msg, 0, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    UnhookWindowsHookEx(g_khook);
quit:
    CloseHandle(g_hEvent);

    ExitProcess(0);
}
