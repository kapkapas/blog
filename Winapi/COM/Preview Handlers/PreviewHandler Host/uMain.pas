unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtnrs, uHostPreview,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Shell.ShellCtrls;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    ShellListView1: TShellListView;
    procedure ShellListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPreview: THostPreviewHandler;
    procedure LoadPreview(const FileName : string);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation


{$R *.dfm}

type
  THostPreviewHandlerClass=class(THostPreviewHandler);


procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FPreview:=nil;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  if FPreview<>nil then
   FPreview.Free;
end;

procedure TFrmMain.LoadPreview(const FileName: string);
begin
  if FPreview<>nil then
   FPreview.Free;

  FPreview := THostPreviewHandler.Create(Self);
  FPreview.Top := 0;
  FPreview.Left := 0;
  FPreview.Width := Panel1.ClientWidth;
  FPreview.Height := Panel1.ClientHeight;
  FPreview.Parent := Panel1;
  FPreview.Align  := alClient;
  //FPreview.FileName:='C:\Users\Dexter\Desktop\RAD Studio Projects\XE2\delphi-preview-handler\main.pas';
  //FPreview.FileName:='C:\Users\Dexter\Desktop\RAD Studio Projects\2010\SMBIOS Delphi\Docs\DSP0119.pdf';
  //FPreview.FileName:='C:\Users\Dexter\Desktop\seleccion\RePLE.msg';
  FPreview.FileName:=FileName;
  THostPreviewHandlerClass(FPreview).Paint;
end;

procedure TFrmMain.ShellListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
 if (ShellListView1.SelectedFolder<>nil) and (FileExists(ShellListView1.SelectedFolder.PathName)) then
 begin
   LoadPreview(ShellListView1.SelectedFolder.PathName);
 end;
end;

end.
