// test1.cpp : Defines the entry point for the console application.
//
#include "StdAfx.h"

#include <tchar.h>

//#pragma warning(disable: 4819)

LRESULT CALLBACK WindowProc(  
    _In_  HWND hwnd,  
    _In_  UINT uMsg,  
    _In_  WPARAM wParam,  
    _In_  LPARAM lParam
);

int CALLBACK WinMain(_In_ HINSTANCE hInstance, _In_ HINSTANCE hPreInstance, _In_ LPSTR lpCmdLine, _In_ int nCmdShow)
{
	 // ����  
    WCHAR* cls_Name = L"My Class";  
    // ��ƴ�����  
    WNDCLASS wc = { };  
    wc.hbrBackground = (HBRUSH)COLOR_WINDOW;  
    wc.lpfnWndProc = WindowProc;  
    wc.lpszClassName = cls_Name;  
    wc.hInstance = hInstance;  
    // ע�ᴰ����  
    RegisterClass(&wc);  
  
    // ��������  
    HWND hwnd = CreateWindow(  
        cls_Name,           //������Ҫ�͸ղ�ע���һ��  
        L"���",  //���ڱ�������  
        WS_OVERLAPPEDWINDOW, //���������ʽ  
        38,                 //��������ڸ�����X����  
        20,                 //��������ڸ�����Y����  
        480,                //���ڵĿ��  
        250,                //���ڵĸ߶�  
        NULL,               //û�и����ڣ�ΪNULL  
        NULL,               //û�в˵���ΪNULL  
        hInstance,          //��ǰӦ�ó����ʵ�����  
        NULL);              //û�и������ݣ�ΪNULL  
    if(hwnd == NULL) //��鴰���Ƿ񴴽��ɹ�  
        return 0;  
  
    // ��ʾ����  
    ShowWindow(hwnd, SW_SHOW);  
  
    // ���´���  
    UpdateWindow(hwnd);  
  
    // ��Ϣѭ��  
    MSG msg;  
    while(GetMessage(&msg, NULL, 0, 0))  
    {  
        TranslateMessage(&msg);  
        DispatchMessage(&msg);  
    }  
    return 0;  
}  
// ��WinMain��ʵ��  
LRESULT CALLBACK WindowProc(  
    _In_  HWND hwnd,  
    _In_  UINT uMsg,  
    _In_  WPARAM wParam,  
    _In_  LPARAM lParam  
)  
{  
    switch(uMsg)  
    {  
    case WM_DESTROY: 
        {  
            PostQuitMessage(0);  
            return 0;  
        }  
    }  
    return DefWindowProc(hwnd, uMsg, wParam, lParam); 
}


