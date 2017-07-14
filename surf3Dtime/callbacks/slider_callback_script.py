SLIDER_CALLBACK_SCRIPT = """
var data = source.data;
var kdata = line_plot_source.data;

var time = time.value;
var button = surface_radio_group.active;

var time_periods = 80;
var num_abilities = 7;
var plot_points = time_periods*num_abilities;

if (button == '0') {
var bpath = bpath_source.data;

window.surface_graph.setOptions({zLabel: 'indiv. savings-b', zMin: -20,
zMax: 50})

x = data['x'];
y = data['y'];
z = data['z'];

beg = time*plot_points;
end = (time+1)*plot_points;
b = bpath['bpath'].slice(beg,end);

for (i = 0; i < z.length; i++) {
z[i] = b[i];
}
source.change.emit();
}

if (button == '1') {
var cpath = cpath_source.data;

window.surface_graph.setOptions({zLabel: 'indiv. consumption-c', zMin: 0,
zMax: 6})

x = data['x'];
y = data['y'];
z = data['z'];

beg = time*plot_points;
end = (time+1)*plot_points;
c = cpath['cpath'].slice(beg,end);

for (i = 0; i < z.length; i++) {
z[i] = c[i];
}
source.change.emit();
}

if (button == '2') {
var npath = npath_source.data;

window.surface_graph.setOptions({zLabel: 'labor supply-n', zMin: 0, zMax: 1})

x = data['x'];
y = data['y'];
z = data['z'];

beg = time*plot_points;
end = (time+1)*plot_points;
n = npath['npath'].slice(beg,end);

for (i = 0; i < z.length; i++) {
z[i] = n[i];
}
source.change.emit();
}

kdata['circle_color'] = Array(time_periods).fill('white');
kdata['circle_color'][time] = '#3288bd';

line_plot_source.change.emit();
"""
