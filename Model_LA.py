import math
import matplotlib.pyplot as plt

# Initialize variables
c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12 = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
e1, e2, e3 =  0.0, 0.0, 0.0
a1, a2, a3, a4, a5, a6, a7, a8, a9, a10 = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 
b1, b2, b3, b4, b5, b6, b7, b8, b9 = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
g, R = 0.0, 0.0
i = 0

rlv_l, rln_l, lr_l = 0.0, 0.0, 0.0
rlv_d, rln_d, rln_abu, lr_d = 0.0, 0.0, 0.0, 0.0
rlv, rln, lr = 0.0, 0.0, 0.0

var_om_x, var_om_y, var_om_z = 0.0, 0.0, 0.0
var_tet, var_gam, var_ps = 0.0, 0.0, 0.0
var_alf, var_bet = 0.0, 0.0
var_x, var_y, var_z = 0.0, 0.0, 0.0
var_lmbd, var_ph = 0.0, 0.0
var_h = 0.0
var_V = 0.0
var_Vx, var_Vz, var_Vy = 0.0, 0.0, 0.0

d_om_x, d_om_y, d_om_z = 0.0, 0.0, 0.0
d_tet, d_gam, d_ps = 0.0, 0.0, 0.0
d_alf, d_bet = 0.0, 0.0
d_lmbd, d_ph = 0.0, 0.0
d_x, d_y, d_z = 0.0, 0.0, 0.0
d_h = 0.0
d_V = 0.0
d_Vn, d_Ve, d_Vup = 0.0, 0.0, 0.0
d_Vx, d_Vz, d_Vy = 0.0, 0.0, 0.0

om_x, om_y, om_z = 0.0, 0.0, 0.0
tet, gam, ps = 0.0, 0.0, 0.0
alf, bet = 0.0, 0.0
lmbd, ph = 0.0, 0.0
x, y, z = 0.0, 0.0, 0.0
V = 0.0
h = 0.0
Vx, Vy, Vz = 0.0, 0.0, 0.0
Vn, Ve, Vup = 0.0, 0.0, 0.0

nu_a, nu_b, nu_c, nu_abu = 0.0, 0.0, 0.0, 0.0
sigma, n_z, a2_abu, a4_abu = 0.0, 0.0, 0.0, 0.0
n = 0

# Set your initial values here

# Replace StrToFloat with float conversion if needed

dt = float(Edit25.Text)
time = int(Edit4.Text)
g = float(Edit15.Text)

om_z = float(Edit1.Text)
alf = float(Edit2.Text)
V = float(Edit3.Text)
h = float(Edit5.Text)
tet = float(Edit6.Text)
om_x = float(Edit8.Text)
om_y = float(Edit9.Text)
bet = float(Edit10.Text)
gam = float(Edit11.Text)
ps = float(Edit12.Text)

rlv_l = float(Edit7.Text)
rln_l = float(Edit13.Text)
lr_l = float(Edit14.Text)

Edit19.Text = str(0)
Edit23.Text = str(0)
Edit20.Text = str(0)

x = float(Edit19.Text)
z = float(Edit20.Text)

Edit21.Text = str(37)
Edit22.Text = str(55)

R = float(Edit24.Text)

lmbd = float(Edit21.Text)
ph = float(Edit22.Text)

d_om_z = 0
d_alf = 0
d_V = 0
d_h = 0
d_tet = 0
d_om_x = 0
d_om_y = 0
d_bet = 0
d_ps = 0
d_gam = 0
d_x = 0
d_y = 0
d_z = 0

c7 = 0.01745 * g
c10 = 0
c11 = 0

a8 = 1
a9 = 0
a10 = 1
b8 = 0
b9 = 0

n = round(time / dt)

for i in range(n):
    c1 = (-1.7611E-07 *  h + 0.004634293) * V - 1.96806E-05 * h - 0.021552062
    c2 = (7.03229E-08 *  h + 0.026270037) * V - 0.000166574 * h - 1.66329068
    c3 = (-1.70689E-06 * h + 0.033820761) * V + 0.000122261 * h - 2.672653753
    c4 = (-2.1553E-07 *  h + 0.008278214) * V - 2.52228E-05 * h - 0.185167179
    c5 = (-9.07702E-09 * h + 0.000160665) * V + 9.95226E-08 * h - 0.001862997
    c6 = 0.01745 * V
    c8 = (9.15268E-09 *  h + 0.000534668) * V - 4.09991E-06 * h - 0.030090726
    c9 = (-4.77422E-08 * h + 0.001281104) * V + 6.63536E-06 * h - 0.061616094

    a1 = (-2.98722E-07 * h + 0.005252132) * V + 7.95891E-06 * h - 0.303231795
    a2 = (-7.4086E-06 *  h + 0.099753184) * V + 0.00053519  * h - 7.30408435
    a3 = (-5.68894E-06 * h + 0.076310767) * V + 0.000317512 * h - 4.755147171
    a4 = (-2.4424E-07 *  h + 0.003936353) * V + 1.10573E-05 * h - 0.195785056
    a5 = (-1.07168E-05 * h + 0.098783215) * V + 0.00062704  * h - 4.333942429
    a6 = (-4.37757E-07 * h + 0.006880651) * V + 1.54168E-05 * h - 0.404014905
    a7 = (-4.51844E-08 * h + 0.000347142) * V + 2.23163E-06 * h + 0.004846659

    b1 = (-1.24356E-06 * h + 0.023315921) * V + 1.1442E-05  * h - 1.3050842
    b2 = (-8.82103E-06 * h + 0.131994685) * V + 0.00046448  * h - 9.152441325
    b3 = (-3.65674E-06 * h + 0.133219825) * V - 0.000580754 * h - 6.050775557
    b4 = (1.59338E-08 *  h - 0.000534718) * V - 2.26525E-06 * h + 0.130916166
    b5 = (-2.18075E-06 * h + 0.019849103) * V + 0.000188526 * h - 1.006994098
    b6 = (-6.56714E-08 * h + 0.001435987) * V + 1.46961E-07 * h - 0.058019521
    b7 = (5.48183E-08 *  h - 0.001080679) * V + 5.96255E-07 * h + 0.204630547

    # *****
    # Calculate nu values
    # *****

    nu_a = (2 * math.sqrt(a2 + a1 * a4) - a1 - a4) / a3
    nu_b = (5 - b1) / b3
    nu_c = (2 * math.sqrt(c2 + c1 * c4) - (c1 + c4 + c5)) / c3
    
    rlv_d = nu_c * d_om_z
    rln_d = nu_a * d_om_y
    lr_d = nu_b * d_om_x

    rlv = rlv_l + rlv_d
    rln = rln_l + rln_d
    lr = lr_l + lr_d

    if a1 * a4 + a2 < 3:
        sigma = (57.3 * b4) * (4 - (a1 * a4 + a2)) / (4 * a7 + a3 * a4 - a2 * a7)
        if sigma < 0:
            sigma = 0

        n_z = -(a4 * var_bet + a7 * rln_l) / (57.3 * b4)
        a2_abu = a2 + (sigma * a3 * a4) / (57.3 * b4 - sigma * a7)
        a4_abu = a4 * 57.3 * b4 / (57.3 * b4 - sigma * a7)
        nu_abu = (2 * math.sqrt(a2_abu + a1 * a4_abu) - a1 - a4_abu) / a3
        rln_abu = nu_abu * d_om_y - sigma * n_z
        rln = rln_l + rln_abu
    
    var_om_z = -(c1 + c5) * d_om_z - (c2 - c4 * c5) * d_alf - c3 * rlv
    var_alf = d_om_z - c4 * d_alf - c10 * d_tet - c9 * rlv
    var_V = -c8 * d_alf - c7 * d_tet
    var_h = -c6 * d_alf + c11 * d_V + c6 * d_tet
    var_tet = d_om_z

    d_om_z = d_om_z + var_om_z * dt
    d_alf = d_alf + var_alf * dt
    d_V = d_V + var_V * dt
    d_h = d_h + var_h * dt
    d_tet = d_tet + var_tet * dt

    V1 = V + d_V
    om_z = om_z + d_om_z * dt
    alf = alf + d_alf * dt
    V = V + d_V
    h = h + d_h * dt
    tet = tet + d_tet * dt

    var_om_y = -a1 * d_om_y - a2 * d_bet - a3 * rln
    var_bet = d_om_y - a4 * d_bet - a7 * rln
    var_ps = d_om_y

    # Calculate var_om_x and var_gam
    var_om_x = -b1 * d_om_x - b3 * lr
    var_gam = d_om_x

    d_om_y = d_om_y + var_om_y * dt
    d_bet = d_bet + var_bet * dt
    d_ps = d_ps + var_ps * dt

    d_om_x = d_om_x + var_om_x * dt
    d_gam = d_gam + var_gam * dt

    om_y = om_y + d_om_y * dt
    bet = bet + d_bet * dt
    ps = ps + d_ps * dt

    om_x = om_x + d_om_x * dt
    gam = gam + d_gam * dt
    Vx = V * math.cos(d_bet) * math.cos(d_alf)
    Vy = -V * math.cos(d_bet) * math.sin(d_alf)
    Vz = V * math.sin(d_bet)

    Vn = Vx * math.cos(d_ps) * math.cos(d_tet) + Vy * math.sin(d_tet) - Vz * math.cos(d_tet) * math.sin(d_ps)
    Vup = Vx * (-math.cos(d_gam) * math.sin(d_tet) * math.cos(d_ps) + math.sin(d_gam) * math.sin(d_ps)) + Vy * math.cos(
        d_gam) * math.cos(d_tet) + Vz * (math.cos(d_gam) * math.sin(d_tet) * math.sin(d_ps) + math.sin(d_gam) * math.cos(
        d_ps))
    Ve = Vx * (math.sin(d_gam) * math.sin(d_tet) * math.cos(d_ps) + math.cos(d_gam) * math.sin(d_ps)) - Vy * math.sin(
        d_gam) * math.cos(d_tet) + Vz * (
                 -math.sin(d_gam) * math.sin(d_tet) * math.sin(d_ps) + math.cos(d_gam) * math.cos(d_ps))

    d_x = Vn * dt
    d_y = Vup * dt
    d_z = Ve * dt
    x = x + d_x
    y = y + d_y
    z = z + d_z

    d_ph = Vn / (R + h) * dt
    d_lmbd = Ve / ((R + h) * math.cos(ph)) * dt

    ph = ph + d_ph
    lmbd = lmbd + d_lmbd

# Initialize your variables here (replace placeholders with actual values)
time = 10  # Replace with your actual time value
dt = 0.1  # Replace with your actual dt value
n = round(time / dt)

# Initialize lists to store data
i_values = list(range(n))
d_om_z_values = []
d_om_x_values = []
d_om_y_values = []
d_ps_values = []
d_tet_values = []
d_gam_values = []
d_alf_values = []
d_bet_values = []
d_h_values = []
Vn_values = []
Vup_values = []
Ve_values = []
ph_values = []
lmbd_values = []

# Initialize your initial variables here (replace placeholders with actual values)
a1 = 0.1
a2 = 0.2
a3 = 0.3
a4 = 0.4
a7 = 0.7

b1 = 0.1
b3 = 0.3
b4 = 0.4

c1 = 0.1
c2 = 0.2
c3 = 0.3
c4 = 0.4
c5 = 0.5
c10 = 1.0

rlv_l = 0.0
rln_l = 0.0
lr_l = 0.0

# Other variables
om_z = 0.0
alf = 0.0
V = 0.0
h = 0.0
tet = 0.0
om_x = 0.0
om_y = 0.0
bet = 0.0
gam = 0.0
ps = 0.0

R = 6371.0  # Earth's radius

# Loop through time steps
for i in range(n):
    # Your calculations here

    # Add calculated values to the lists
    d_om_z_values.append(om_z)
    d_om_x_values.append(om_x)
    d_om_y_values.append(om_y)
    d_ps_values.append(ps)
    d_tet_values.append(tet)
    d_gam_values.append(gam)
    d_alf_values.append(alf)
    d_bet_values.append(bet)
    d_h_values.append(h)
    Vn_values.append(Vn)
    Vup_values.append(Vup)
    Ve_values.append(Ve)
    ph_values.append(ph)
    lmbd_values.append(lmbd)

# Create subplots for each series
fig, axs = plt.subplots(4, 4, figsize=(12, 12))

# Add data to the subplots
axs[0, 0].plot(i_values, d_om_z_values, label='d_om_z')
axs[0, 0].set_title('d_om_z')

axs[0, 1].plot(i_values, d_om_x_values, label='d_om_x')
axs[0, 1].set_title('d_om_x')

axs[0, 2].plot(i_values, d_om_y_values, label='d_om_y')
axs[0, 2].set_title('d_om_y')

axs[0, 3].plot(i_values, d_ps_values, label='d_ps')
axs[0, 3].set_title('d_ps')

axs[1, 0].plot(i_values, d_tet_values, label='d_tet')
axs[1, 0].set_title('d_tet')

axs[1, 1].plot(i_values, d_gam_values, label='d_gam')
axs[1, 1].set_title('d_gam')

axs[1, 2].plot(i_values, d_alf_values, label='d_alf')
axs[1, 2].set_title('d_alf')

axs[1, 3].plot(i_values, d_bet_values, label='d_bet')
axs[1, 3].set_title('d_bet')

axs[2, 0].plot(i_values, d_h_values, label='d_h')
axs[2, 0].set_title('d_h')

axs[2, 1].plot(i_values, Vn_values, label='Vn')
axs[2, 1].set_title('Vn')

axs[2, 2].plot(i_values, Vup_values, label='Vup')
axs[2, 2].set_title('Vup')

axs[2, 3].plot(i_values, Ve_values, label='Ve')
axs[2, 3].set_title('Ve')

axs[3, 0].plot(i_values, ph_values, label='ph')
axs[3, 0].set_title('ph')

axs[3, 1].plot(i_values, lmbd_values, label='lmbd')
axs[3, 1].set_title('lmbd')

# Adjust layout
plt.tight_layout()

# Show the plot
plt.show()