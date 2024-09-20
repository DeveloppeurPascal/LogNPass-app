/// <summary>
/// ***************************************************************************
///
/// Log'n Pass
///
/// Copyright 2016-2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://lognpass.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/LogNPass-app
///
/// ***************************************************************************
/// File last update : 2024-05-06T19:26:24.000+02:00
/// Signature : c8d19c09fc1cf495e9ad998393f016ecf8362a28
/// ***************************************************************************
/// </summary>

unit dm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  FMX.ImgList;

type
  TDataModule1 = class(TDataModule)
    ImageList1: TImageList;
    imgAppLogo: TImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
