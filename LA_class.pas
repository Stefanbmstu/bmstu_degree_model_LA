//Unit name
unit LA_class;

interface
//uses declares all of the modules (external and slef-written like Unit1 that we need fot our project
 uses
  Graphics, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Math;
 //type: Here we're going to declare classes
 type
 //Pre-declaration
 TController=class;
 TStorage=class;
 //TBorder doesnt need pre-declaration since it's the last class we're declaring
 //TBorder = interface class, parent-class descrived in Unit1 (TForm1)
 TBorder=class(TForm1)
 //Fields belong to private
   private
    FC:TController;
    //Methods and properties can be put in public
   public
    property PC:TController read FC write FC;
    //Method for Button stuff
    procedure ButtonClick(Sender:TObject);
    //Initials required to rewrite event-processing
    procedure Initials();
 end;

 //TController contains all "math" and main application core-procedures
 TController=class
  private
    FB:TBorder;
    FS:TStorage;
    Fox:real;
    Foy:real;
    Foz:real;
  public
    property PB:TBorder read FB write FB;
    property PS:TStorage read FS write FS;
 end;

 //Storage is database class, currently does nothing
 TStorage=class
  private
    FC:TController;
  public
    property PC:TController read FC write FC;

 end;

 //Implementation contains detailed description of methods functionality
implementation

procedure TBorder.ButtonClick(Sender: TObject); //КНОПКА ПОЛЕТА
  var
    c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,e1,e2,e3:real;           //коэффициенты продольного движения (по тангажу) в точке
    a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,b1,b2,b3,b4,b5,b6,b7,b8,b9:real; //коэффициенты бокового движения (по крену и курсу) в точке
    time, dt:real;                           //общее время и шаг интегррования
    g, R: real;                             //ускорение свободного падения и радиус  Земли
    i:integer;                              //итерация

    //УПРАВЛЕНИЕ
    rlv_l, rln_l, lr_l: real;               //значение угловых отклонений рулей управления летчиком     //град
    rlv_d, rln_d, rln_abu, lr_d: real;               //значение угловых отклонений демпферов рулей управления    //град
    rlv, rln, lr: real;                     //абсолютное значение угловых отклонений рулей управления   //град

    //ВАРИАЦИИ
    var_om_x, var_om_y, var_om_z: real;     //вариации угловых скоростей                      //град/с
    var_tet, var_gam, var_ps: real;         //вариации углов ориентации                       //град
    var_alf, var_bet: real;                 //вариации углов атаки и скольжения               //град
    var_x, var_y, var_z: real;              //вариации стартовых координат                    //м
    var_lmbd, var_ph: real;                 //вариации долготы и широты                       //град
    var_h: real;                            //вариация высоты                                 //м
    var_V: real;                            //вариация скорости в осях скоростной             //м/с
    var_Vx, var_Vz, var_Vy: real;
//    var_Vn, var_Ve, var_Vup: real;

    //ПРИРАЩЕНИЯ
    d_om_x, d_om_y, d_om_z: real;           //приращение угловых скоротсей                    //град/с
    d_tet, d_gam, d_ps: real;               //приращение углов ориентации                     //град
    d_alf, d_bet: real;                     //приращение углов атаки и скольжения             //град
    d_lmbd, d_ph: real;                     //приращение долготы и широты                     //град
    d_x, d_y, d_z: real;                    //приращение стартовых координат                  //м
    d_h:real;                               //приращение высоты                               //м
    d_V: real;                              //приращение скорости в осях скоростной           //м/с
    d_Vn, d_Ve, d_Vup: real;
    d_Vx, d_Vz, d_Vy: real;


    //ЗНАЧЕНИЯ
    om_x, om_y, om_z: real;                 //значение угловых скоротсей                      //град/с
    tet, gam, ps: real;                     //значение углов ориентации                       //град
    alf, bet: real;                         //значение углов атаки и скольжения               //град
    lmbd, ph: real;                         //значение долготы и широты                       //град
    x, y, z: real;                          //значение высоты                                 //м
    V: real;                                //значение скорости в осях скоростной             //м/с
    h: real;                                //значение высоты                                 //м
    Vx, Vy, Vz: real;                       //значение скоротсей в связанных осях             //м/с
    Vn, Ve, Vup: real;                      //значение скоротсей в нормальных осях            //м/с

    nu_a, nu_b, nu_c, nu_abu: real;                 //передаточное число демпферов курса, крена и тангажа
    sigma, n_z, a2_abu, a4_abu: real;
    n:integer;                              //число шагов интегрирования

  begin

    Series1.Clear;                          //Emptying the Series before creating new one
    Series2.Clear;
    Series3.Clear;
    Series4.Clear;
    Series5.Clear;
    Series6.Clear;
    Series7.Clear;
    Series8.Clear;
    Series9.Clear;
    Series10.Clear;
    Series11.Clear;
    Series12.Clear;
    Series13.Clear;
    Series14.Clear;

    dt:=StrToFloat(Edit25.Text);              //шаг интегрирования             //с
    time:=StrToInt(Edit4.Text);               //время полета                   //с
    g:= StrToFloat(Edit15.Text);              //ускорение свободного падения   //м/с2

    //НАЧАЛЬНЫЕ ЗНАЧЕНИЯ
    om_z:=StrToFloat(Edit1.Text);
    alf:=StrToFloat(Edit2.Text);
    V:=StrToFloat(Edit3.Text);
    h:=StrToFloat(Edit5.Text);
    tet:=StrToFloat(Edit6.Text);
    om_x:=StrToFloat(Edit8.Text);
    om_y:=StrToFloat(Edit9.Text);
    bet:=StrToFloat(Edit10.Text);
    gam:=StrToFloat(Edit11.Text);
    ps:=StrToFloat(Edit12.Text);

    //УПРАВЛЕНИЕ
    rlv_l:=StrToFloat(Edit7.Text);
    rln_l:=StrToFloat(Edit13.Text);
    lr_l:=StrToFloat(Edit14.Text);

    Edit19.Text:=FloatToStr(0);              //обнуление стартовых координат (чтоб не накапливаись в случае незакрытия формы)
    Edit23.Text:=FloatToStr(0);
    Edit20.Text:=FloatToStr(0);

    x:=StrToFloat(Edit19.Text);             //стартовые координаты      //м
    y:=StrToFloat(Edit23.Text);
    z:=StrToFloat(Edit20.Text);

    Edit21.Text:=FloatToStr(37);            //примерные угловые координаты Москвы (чтоб не накапливаись в случае незакрытия формы)
    Edit22.Text:=FloatToStr(55);

    R:=StrToFloat(Edit24.Text);

    lmbd:=StrToFloat(Edit21.Text);
    ph:=StrToFloat(Edit22.Text);

    d_om_z:=0;
    d_alf:=0;
    d_V:=0;
    d_h:=0;
    d_tet:=0;
    d_om_x:=0;
    d_om_y:=0;
    d_bet:=0;
    d_ps:=0;
    d_gam:=0;
    d_x:=0;
    d_y:=0;
    d_z:=0;

    //коэффициенты для точки 69 полетной области (должна быть функция от H , V - апроксимация по 2м)
    //* cos ( tet );
    c7:= 0.01745 * g; // * cos ( tet );
    c10:= 0; //( g / 266 ) * sin (tet );
    c11:= 0; //sin (tet);
//    //коэффициенты принимаем статичными, зависят только от начальных условий полета (в нашем случае прямолинейный горизонтальный)
    a8:= 1;   //cos ( alf );
    a9:= 0;  //tan ( tet ) * cos ( gam );
    a10:= 1; //sec ( tet ) * cos ( gam );
    b8:= 0; //om_z * tan ( tet );
    b9:= 0; //om_z * sec ( tet );

    n:=round(time / dt); //We use round() to be able to input real-number in Edit without causing exception

    for i := 0 to n-1 do  //начианем интегрироание внутри заданного отрезка времени полета (тактирование и шаг совпадают)
    begin


      c1:= ( - 1.7611E-07  * h + 0.004634293 ) * V - 1.96806E-05 * h - 0.021552062;
      c2:= (   7.03229E-08 * h + 0.026270037 ) * V - 0.000166574 * h - 1.66329068 ;
      c3:= ( - 1.70689E-06 * h + 0.033820761 ) * V + 0.000122261 * h - 2.672653753;
      c4:= ( - 2.1553E-07  * h + 0.008278214 ) * V - 2.52228E-05 * h - 0.185167179;
      c5:= ( - 9.07702E-09 * h + 0.000160665 ) * V + 9.95226E-08 * h - 0.001862997;
      c6:= 0.01745 * V;
      c8:= (   9.15268E-09 * h + 0.000534668 ) * V - 4.09991E-06 * h - 0.030090726;
      c9:= ( - 4.77422E-08 * h + 0.001281104 ) * V + 6.63536E-06 * h - 0.061616094;

      a1:= ( - 2.98722E-07 * h + 0.005252132 ) * V + 7.95891E-06 * h - 0.303231795;
      a2:= ( - 7.4086E-06  * h + 0.099753184 ) * V + 0.00053519  * h - 7.30408435 ;
      a3:= ( - 5.68894E-06 * h + 0.076310767 ) * V + 0.000317512 * h - 4.755147171;
      a4:= ( - 2.4424E-07  * h + 0.003936353 ) * V + 1.10573E-05 * h - 0.195785056;
      a5:= ( - 1.07168E-05 * h + 0.098783215 ) * V + 0.00062704  * h - 4.333942429;
      a6:= ( - 4.37757E-07 * h + 0.006880651 ) * V + 1.54168E-05 * h - 0.404014905;
      a7:= ( - 4.51844E-08 * h + 0.000347142 ) * V + 2.23163E-06 * h + 0.004846659;

      b1:= ( - 1.24356E-06 * h + 0.023315921 ) * V + 1.1442E-05  * h - 1.3050842  ;
      b2:= ( - 8.82103E-06 * h + 0.131994685 ) * V + 0.00046448  * h - 9.152441325;
      b3:= ( - 3.65674E-06 * h + 0.133219825 ) * V - 0.000580754 * h - 6.050775557;
      b4:= (   1.59338E-08 * h - 0.000534718 ) * V - 2.26525E-06 * h + 0.130916166;
      b5:= ( - 2.18075E-06 * h + 0.019849103 ) * V + 0.000188526 * h - 1.006994098;
      b6:= ( - 6.56714E-08 * h + 0.001435987 ) * V + 1.46961E-07 * h - 0.058019521;
      b7:= (   5.48183E-08 * h - 0.001080679 ) * V + 5.96255E-07 * h + 0.204630547;

      // *********
      // ** КСУ **
      // *********

      //ДЕМПФЕРЫ

      nu_a:= ( 2 * sqrt( a2 + a1 * a4 ) - a1 - a4 )/a3; //передаточные числа
      nu_b:= ( 5 - b1 )/b3;
      nu_c:= ( 2 * sqrt( c2 +c1 * c4 ) - (c1 + c4 + c5) )/ c3;

      rlv_d:= nu_c  * d_om_z;  //введение демпферов
      rln_d:= nu_a  * d_om_y;
      lr_d:=  nu_b  * d_om_x;

      rlv:=  rlv_l + rlv_d;
      rln:=  rln_l + rln_d;
      lr :=  lr_l  + lr_d;

      if a1 * a4 + a2 < 3  then //введение автомата боковой устойчивости
        begin

          sigma:= ( 57.3 * b4 ) * ( 4 - ( a1 * a4 + a2 ) ) / ( 4 * a7 + a3 * a4 - a2 * a7 );
          if sigma < 0 then sigma := 0 ;

          n_z := - (a4 * var_bet + a7 * rln_l) / ( 57.3 * b4) ;
          a2_abu := a2 + ( sigma * a3 * a4 ) / ( 57.3 * b4 - sigma * a7 );
          a4_abu := a4 * 57.3 * b4 / ( 57.3 * b4 - sigma * a7 );
          nu_abu := ( 2 * sqrt( a2_abu + a1 * a4_abu ) - a1 - a4_abu )/a3;
          rln_abu:= nu_abu * d_om_y - sigma * n_z;
          rln:= rln_l + rln_abu;

        end;

      // ********
      // ** ЛА **
      // ********


      //*****ПРОДОЛЬНОЕ ДВИЖЕНИЕ*******

      //НАКОПЛЕНИЕ ВАРИАЦИЙ
      var_om_z:= - ( c1 + c5 ) * d_om_z - ( c2 - c4 * c5 )  * d_alf                                 - c3 * rlv;//- c5 * c10 * d_tet  - ( e3 - c5 * e2 ) * d_V
      var_alf:=                  d_om_z - c4                * d_alf - c10                   * d_tet - c9 * rlv;//- e2 * d_V
      var_V:=                           - c8                * d_alf                 - c7    * d_tet;//  - e1 * d_V
      var_h:=                           - c6                * d_alf + c11 * d_V     + c6    * d_tet;
      var_tet:=                  d_om_z;

      //НАКОПЛЕНИЕ ПРИРАЩЕНИЙ
      d_om_z:=  d_om_z + var_om_z * dt;
      d_alf:=   d_alf  + var_alf  * dt;
      d_V:=     d_V    + var_V    * dt;
      d_h:=     d_h    + var_h    * dt;
      d_tet:=   d_tet  + var_tet  * dt;

      //НАКОПЛЕНИЕ ЗНАЧЕНИЙ
//      V1 := V + d_V;
//      om_z:=  om_z + d_om_z * dt;
//      alf:=   alf  + d_alf  * dt;
//        V:=  V  +  d_V;
//      h:=     h    + d_h    * dt;
//      tet:=   tet  + d_tet  * dt;

      //*****РАЗДЕЛЬНОЕ БОКОВОЕ ДВИЖЕНИЕ******

      //НАКОПЛЕНИЕ ВАРИАЦИЙ

      //рысканье-скольжение
      var_om_y:=    - a1 * d_om_y - a2 * d_bet - a3 * rln; // - b6 * d_om_x - b5 * lr;
      var_bet:=            d_om_y - a4 * d_bet - a7 * rln; // - b4 * d_gam - b3 * lr; //+ b7 * d_om_x
      var_ps:=             d_om_y;    // - b9 * d_gam; //a10 = 1

      //крен
      var_om_x:=  - b1 * d_om_x - b3 * lr;  //- b2 * d_bet - a6 * om_y
      var_gam:=          d_om_x;            // + b8 (=0) * d_gam; //- a9 * om_y - a4 * d_bet

      //НАКОПЛЕНИЕ ПРИРАЩЕНИЙ

      //рысканье-скольжение
      d_om_y:= d_om_y + var_om_y * dt;
      d_bet:=  d_bet  + var_bet  * dt;
      d_ps:=   d_ps   + var_ps   * dt;

      //крен
      d_om_x:= d_om_x + var_om_x * dt;
      d_gam:=  d_gam  + var_gam  * dt;


      //НАКОПЛЕНИЕ ЗНАЧЕНИЙ
//
//      //рысканье-скольжение
//      om_y:= om_y + d_om_y * dt;
//      bet:=  bet  + d_bet  * dt;
//      ps:=   ps   + d_ps   * dt;
//
//      //крен
//      om_x:= om_x + d_om_x * dt;
//      gam:=  gam  + d_gam  * dt;

      // *********
      // ** ИНС **
      // *********

      //****СКОРОСТИ*****
      //СКОРОСТИ В ПРОЕКЦИЯХ НА СВЯЗАННЫЕ ОСИ

      Vx :=   V * cos (d_bet) * cos (d_alf);
      Vy := - V * cos (d_bet) * sin (d_alf);
      Vz :=   V * sin (d_bet);

      //СКОРОСТИ В ПРОЕКЦИЯХ НА НОРМАЛЬЫНЕ ОСИ
      Vn  :=  Vx *    cos (d_ps)  * cos (d_tet)                                          + Vy * sin (d_tet)               - Vz *   cos (d_tet) * sin (d_ps);
      Vup :=  Vx * (- cos (d_gam) * sin (d_tet) * cos (d_ps) + sin (d_gam) * sin (d_ps)) + Vy * cos (d_gam) * cos (d_tet) + Vz * ( cos (d_gam) * sin (d_tet) * sin (d_ps) + sin (d_gam) * cos (d_ps));
      Ve  :=  Vx * (  sin (d_gam) * sin (d_tet) * cos (d_ps) + cos (d_gam) * sin (d_ps)) - Vy * sin (d_gam) * cos (d_tet) + Vz * (-sin (d_gam) * sin (d_tet) * sin (d_ps) + cos (d_gam) * cos (d_ps));

      //****КООРДИНАТЫ*****

      //НАКОПЛЕНИЕ ВАРИАЦИЙ

      //НАКОПЛЕНИЕ ПРИРАЩЕНИЙ
//      d_x:= Vn  * dt;
//      d_y:= Vup * dt;
//      d_z:= Ve  * dt;
//
//      //НАКОПЛЕНИЕ ЗНАЧЕНИЙ
//      x:= x + d_x ;
//      y:= y + d_y;
//      z:= z + d_z;

      //НАКОПЛЕНИЕ ПРИРАЩЕНИЙ
      d_ph:=   Vn / (R + H) * dt;
      d_lmbd:= Ve/ ( (R + H) * cos(ph) ) * dt ;

      //НАКОПЛЕНИЕ ЗНАЧЕНИЙ
      ph:= ph + d_ph;
      lmbd:= lmbd + d_lmbd;

      //ГРАФИКИ
      Series1.AddXY(i,d_om_z);
      Series6.AddXY(i,d_om_x);
      Series7.AddXY(i,d_om_y);

      Series2.AddXY(i,d_ps);
      Series3.AddXY(i,d_tet);
      Series4.AddXY(i,d_gam);

      Series5.AddXY(i,d_alf);
      Series8.AddXY(i,d_bet);

      Series9.AddXY(i,d_h);

      Series10.AddXY(i,Vn);
      Series11.AddXY(i,Vup);
      Series12.AddXY(i,Ve);

      Series13.AddXY(i,ph);
      Series14.AddXY(i,lmbd);

    end;

    Edit16.Text := FormatFloat ('0.0', Vx);  //число знаков после запятой
    Edit17.Text := FormatFloat ('0.0', Vy);
    Edit18.Text := FormatFloat ('0.0', Vz);

    Edit19.Text := FormatFloat ('0.00', x);
    Edit23.Text := FormatFloat ('0.00', y);
    Edit20.Text := FormatFloat ('0.00', z);

    Edit21.Text := FormatFloat ('0.0000', lmbd);
    Edit22.Text := FormatFloat ('0.0000', ph);

  end;


  //Set event-handler of TBorder Button to the one we've wrote before
  procedure TBorder.Initials;
  begin
    TBorder(self).Button1.OnClick:=TBorder(self).ButtonClick;
  end;

end.
