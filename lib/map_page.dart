import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'phase.dart';
import 'html_widget.dart';
import 'variant.dart';
import 'spinner_widget.dart';

String _dippyMap = r'''
var SVG = "http://www.w3.org/2000/svg";
// Based on http://godsnotwheregodsnot.blogspot.se/2012/09/color-distribution-methodology.html.
var contrasts = [
  "#F44336", "#2196F3", "#80DEEA", "#90A4AE", "#4CAF50", "#FFC107", "#F5F5F5",
  "#009688", "#FFEB3B", "#795548", "#E91E63", "#CDDC39", "#FF9800", "#D05CE3",
  "#9A67EA", "#FF6090", "#6EC6FF", "#80E27E", "#A98274", "#CFCFCF", "#FF34FF",
  "#1CE6FF", "#FFDBE5", "#FF7961", "#C66900", "#9C27B0", "#3F51B5", "#C8B900",
  "#C2185B", "#BA000D", "#607D8B", "#087F23", "#673AB7", "#0069C0", "#34515E",
  "#002984", "#004C40", "#FFFF6E", "#B4FFFF", "#6A0080", "#757DE8", "#04F757",
  "#CEFDAE", "#974D2B", "#974D2B", "#FF2F80", "#0CBD66", "#FF90C9", "#BEC459",
  "#0086ED", "#FFB500", "#0AA6D8", "#A05837", "#EEC3FF", "#456648", "#D790FF",
  "#6A3A4C", "#324E72", "#A4E804", "#CB7E98", "#0089A3", "#404E55", "#FDE8DC",
  "#5B4534", "#922329", "#3A2465", "#99ADC0", "#BC23FF", "#72418F", "#201625",
  "#FFF69F", "#549E79", "#9B9700", "#772600", "#6B002C", "#6367A9", "#A77500",
  "#7900D7", "#1E6E00", "#C8A1A1", "#885578", "#788D66", "#7A87A1", "#B77B68",
  "#456D75", "#6F0062", "#00489C", "#001E09", "#C2FF99", "#C0B9B2", "#CC0744",
  "#A079BF", "#C2FFED", "#372101", "#00846F", "#013349", "#300018", "#A1C299",
  "#7B4F4B", "#000035", "#DDEFFF", "#D16100", "#B903AA",
];

var Poi = class Poi {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  add(p) {
    return new Poi(this.x + p.x, this.y + p.y);
  }
	sub(p) {
    return new Poi(this.x - p.x, this.y - p.y);
  }
	len() {
    return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
  }
  div(f) {
    return new Poi(this.x / f, this.y / f);
  }
  mul(f) {
    return new Poi(this.x * f, this.y * f);
  }
	orth() {
    return new Poi(-this.y, this.x);
  }
}

var Vec = class Vec {
  constructor(p1, p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
	len() {
    return this.p2.sub(this.p1).len();
  }
  dir() {
    return this.p2.sub(this.p1).div(this.len());
  }
  orth() {
    return this.dir().orth();
  }
}

var DippyMap = class DippyMap {
  constructor(el) {
    this.el = el;
    this.clickListenerRemovers = [];
  }

	selEscape(sel) {
		return sel.replace("/", "\\/");
	}
	
	centerOf(province) {
	  const center = this.el.querySelector(`#${this.selEscape(province)}Center`);
		const match = /^m\s+([\d-.]+),([\d-.]+)\s+/.exec(center.getAttribute("d"));
		const x = Number(match[1]);
		const y = Number(match[2]);
		const parentTransform = center.parentElement.getAttribute("transform");
		if (parentTransform != null) {
			const transMatch = /^translate\(([\d.eE-]+),\s*([\d.eE-]+)\)$/.exec(
				parentTransform
			);
			x += Number(transMatch[1]) - 1.5;
			y += Number(transMatch[2]) - 2;
		}
		return new Poi(x, y);
	}
	
	showProvinces() {
		this.el.querySelector("#provinces").removeAttribute("style");
	}
	
	colorSC(province, color) {
		this.el.querySelector(`#${this.selEscape(province)}Center`).style.stroke = color;
	}
	
	colorProvince(province, color) {
		const path = this.el.querySelector(`#${this.selEscape(province)}`);
		path.removeAttribute("style");
		path.setAttribute("fill", color);
		path.setAttribute("fill-opacity", "0.8");
	}
	
	hideProvince(province) {
		const path = this.el.querySelector("#" + this.selEscape(province));
		path.removeAttribute("style");
		path.setAttribute("fill", "#ffffff");
		path.setAttribute("fill-opacity", "0");
	}
	
	highlightProvince(province) {
		const prov = this.el.querySelector(`#${this.selEscape(province)}`);
		const copy = prov.cloneNode();
		copy.setAttribute("id", `${prov.getAttribute("id")}_highlight`);
		copy.setAttribute("style", "fill:url(#stripes)");
		copy.setAttribute("fill-opacity", "1");
		copy.removeAttribute("transform");
		let curr = prov;
		while (curr != null && curr.getAttribute != null) {
			const trans = curr.getAttribute("transform");
			if (trans != null) {
				copy.setAttribute("transform", trans);
			}
			curr = curr.parentNode;
		}
		copy.setAttribute("stroke", "none");
		this.el.querySelector("#highlights").appendChild(copy);
	}
	
	unhighlightProvince(province) {
		this.el.querySelector(`#${this.selEscape(province)}_highlight`).remove();
	}
	
	clearClickListeners() {
	  this.clickListenerRemovers.forEach((f) => { f(); });
	}
	
	addClickListener(province, handler, options) {
		const nohighlight = (options || {}).nohighlight;
		const permanent = (options || {}).permanent;
		const touch = (options || {}).touch;
		if (!nohighlight) {
			this.highlightProvince(province);
		}
		const prov = this.el.querySelector(`#${this.selEscape(province)}`);
		const copy = prov.cloneNode();
		copy.setAttribute("id", `${prov.getAttribute("id")}_click`);
		copy.setAttribute("style", "fill:#000000;fill-opacity:0;stroke:none;");
		copy.setAttribute("stroke", "none");
		copy.removeAttribute("transform");
		let x = 0;
		let y = 0;
		let curr = prov;
		while (curr != null && curr.getAttribute != null) {
			const trans = curr.getAttribute("transform");
			if (trans != null) {
				const transMatch = /^translate\(([\d.eE-]+),\s*([\d.eE-]+)\)$/.exec(trans);
				x += Number(transMatch[1]);
				y += Number(transMatch[2]);
			}
			curr = curr.parentNode;
		}
		copy.setAttribute("transform", `translate(${x}, ${y})`);
		el.appendChild(copy);
		const clickHandler = (ev) => { handler(province); };
		copy.addEventListener("click", clickHandler);
		if (touch) {
		  const touchstartHandler = (ev) => {
		    ev.preventDefault();
		    let touchendHandler = null;
		    let touchmoveHandler = null;
		    let moved = false;
		    const at = new Date().getTime();
		    const unregisterTouchHandlers = () => {
		      copy.removeEventListener("touchend", touchendHandler);
		      copy.removeEventListener("touchmove", touchmoveHandler);
		    };
		    touchendHandler = (ev) => {
		      if (!moved || new Date().getTime() - at < 300) {
		        handler(province);
		      }
		      unregisterTouchHandlers();
		    };
		    copy.addEventListener("touchend", touchEndHandler);
		    touchmoveHandler = function(ev) {
		      moved = true;
		    };
		    copy.addEventListener("touchmove", touchmoveHandler);
		  };
		  copy.addEventListener("touchstart", touchstartHandler);
			if (!permanent) {
				this.clickListenerRemovers.push(() => {
					if (!nohighlight) {
						this.unhighlightProvince(province);
					}
					if (touch) {
						copy.removeEventListener("touchstart", touchstartHandler);
					}
					copy.removeEventListener("click", clickHandler);
				});
			}
		}
	}
	
	addBox(province, corners, color, opts = {}) {
	  const stroke = (opts.stroke || "#000000");
		const loc = this.centerOf(province);
		loc.x -= 3;
		loc.y -= 3;
		const all = Math.PI * 2;
		const step = all / corners;
		let startAngle = Math.PI * 1.5;
		if (corners % 2 === 0) {
			startAngle += step / 2;
		}
		let angle = startAngle;
		const path = document.createElementNS(SVG, "path");
		path.setAttribute(
			"style",
			`fill-rule:evenodd;fill:${color};stroke:${stroke};stroke-width:0.5;stroke-miterlimit:4;stroke-opacity:1.0;fill-opacity:0.9;`
		);
		let d = "";
		const subBox = (boundF) => {
			d += `M ${(loc.x + Math.cos(angle) * boundF)},${(loc.y + Math.sin(angle) * boundF)}`;
			for (let i = 1; i < corners; i++) {
				angle += step;
				d += ` L ${(loc.x + Math.cos(angle) * boundF)},${(loc.y + Math.sin(angle) * boundF)}`;
			}
			d += " z";
		}
		subBox(27);
		subBox(20);
		path.setAttribute("d", d);
		this.el.querySelector("#orders").appendChild(path);
	}
	
	addArrow(provs, color, opts = {}) {
	  const stroke = (opts.stroke || "#000000");
		let start = null;
		let middle = null;
		let end = null;
		if (provs.length === 3 && provs[1] === provs[2]) {
			provs.pop();
		}
		if (provs.length === 2) {
			start = this.centerOf(provs[0]);
			end = this.centerOf(provs[1]);
			middle = start.add(end.sub(start).div(2.0));
		} else {
			start = this.centerOf(provs[0]);
			middle = this.centerOf(provs[1]);
			end = this.centerOf(provs[2]);
		}
		const boundF = 3;
		const headF1 = boundF * 3;
		const headF2 = boundF * 6;
		const spacer = boundF * 2;
		const part1 = new Vec(start, middle);
		const part2 = new Vec(middle, end);
		const start0 = start.add(part1.dir().mul(spacer)).add(part1.orth().mul(boundF));
		const start1 = start.add(part1.dir().mul(spacer)).sub(part1.orth().mul(boundF));
		const sumOrth = part1.orth().add(part2.orth());
		const avgOrth = sumOrth.div(sumOrth.len());
		const control0 = middle.add(avgOrth.mul(boundF));
		const control1 = middle.sub(avgOrth.mul(boundF));
		const end0 = end.sub(part2.dir().mul(spacer + headF2)).add(part2.orth().mul(boundF));
		const end1 = end.sub(part2.dir().mul(spacer + headF2)).sub(part2.orth().mul(boundF));
		const end3 = end.sub(part2.dir().mul(spacer));
		const head0 = end0.add(part2.orth().mul(headF1));
		const head1 = end1.sub(part2.orth().mul(headF1));

		const path = document.createElementNS(SVG, "path");
		path.setAttribute(
			"style",
			`fill:${color};stroke:${stroke};stroke-width:0.5;stroke-miterlimit:4;stroke-opacity:1.0;fill-opacity:0.7;`
		);
		let d = `M ${start0.x},${start0.y}`;
		d += ` C ${control0.x},${control0.y},${control0.x},${control0.y},${end0.x},${end0.y}`;
		d += ` L ${head0.x},${head0.y}`;
		d += ` L ${end3.x},${end3.y}`;
		d += ` L ${head1.x},${head1.y}`;
		d += ` L ${end1.x},${end1.y}`;
		d +=
			` C ${control1.x},${control1.y},${control1.x},${control1.y},${start1.x},${start1.y}`;
		d += " z";
		path.setAttribute("d", d);
		this.el.querySelector("#orders").appendChild(path);
	}
	
	addCross(province, color, opts = {}) {
	  const stroke = (opts.stroke || "#000000");
		const bound = 14;
		const width = 4;
		const loc = this.centerOf(province);
		loc.x -= 3;
		loc.y -= 3;
		const path = document.createElementNS(SVG, "path");
		path.setAttribute(
			"style",
			`fill:${color};stroke:${stroke};stroke-width:0.5;stroke-miterlimit:4;stroke-opacity:1.0;fill-opacity:0.9;`
		);
		var d =
			`M ${loc.x},${loc.y + width} L ${loc.x + bound},${loc.y + bound + width} ` +
			`L ${loc.x + bound + width},${loc.y + bound} ` +
			`L ${loc.x + width},${loc.y} ` +
			`L ${loc.x + bound + width},${loc.y - bound} ` +
			`L ${loc.x + bound},${loc.y - bound - width} ` +
			`L ${loc.x},${loc.y - width} ` +
			`L ${loc.x - bound},${loc.y - bound - width} ` +
			`L ${loc.x - bound - width},${loc.y - bound} ` +
			`L ${loc.x - width},${loc.y} ` +
			`L ${loc.x - bound - width},${loc.y + bound} ` +
			`L ${loc.x - bound},${loc.y + bound + width} z`;
		path.setAttribute("d", d);
		this.el.querySelector("#orders").appendChild(path);
	}
	
	removeOrders() {
		this.el.querySelector("#orders").innerHTML = '';
	}
	
	addOrder(order, color, opts = {}) {
		if (order[1] === "Hold") {
			this.addBox(order[0], 4, color, opts);
		} else if (order[1] === "Move") {
			this.addArrow([order[0], order[2]], color, opts);
		} else if (order[1] === "MoveViaConvoy") {
			this.addArrow([order[0], order[2]], color, opts);
			this.addBox(order[0], 5, color, opts);
		} else if (order[1] === "Build") {
			this.addUnit("unit" + order[2], order[0], color, false, true, "#orders", opts);
		} else if (order[1] === "Disband") {
			this.addCross(order[0], color, opts);
			this.addBox(order[0], 4, color, opts);
		} else if (order[1] === "Convoy") {
			this.addBox(order[0], 5, color, opts);
			this.addArrow([order[2], order[0], order[3]], color, opts);
		} else if (order[1] === "Support") {
			if (order.length === 3) {
				this.addBox(order[0], 3, color, opts);
				this.addArrow([order[2], order[3]], color, opts);
			} else {
				this.addBox(order[0], 3, color);
				this.addArrow([order[0], order[2], order[3]], color, opts);
			}
		}
	}
	
	removeUnits(layer) {
		if (typeof layer === "undefined") {
			layer = "#units";
		}
		this.el.querySelector(layer).innerHTML = '';
	}
	
	addUnit(sourceId, province, color, dislodged, build, layer, opts = {}) {
	  const stroke = (opts.stroke || "#000000");
		if (typeof layer === "undefined") {
			layer = "#units";
		}
		const shadow = document.querySelector(`#${sourceId} #shadow`).cloneNode();
		const hull = document.querySelector(`#${sourceId} #hull`);
		const body = document.querySelector(`#{sourceId} #body`);
		const loc = this.centerOf(province);
		let unit = null;
		let opacity = 1;
		if (dislodged) {
			loc.x += 5;
			loc.y += 5;
			opacity = 0.73;
		}
		loc.y -= 11;
		if (hullQuery != null) {
			unit = hull.cloneNode();
			loc.x -= 65;
			loc.y -= 15;
		} else {
			unit = body.cloneNode();
			loc.x -= 40;
			loc.y -= 5;
		}
		shadow.setAttribute("transform", `translate(${loc.x}, ${loc.y})`);
		unit.setAttribute("transform", `translate(${loc.x}, ${loc.y})`);
		if (build) {
			color = "#000000";
		}
		unit.setAttribute(
			"style",
			`fill:${color};fill-opacity:${opacity};stroke:${stroke};stroke-width:1;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none`
		);
		this.el.querySelector(layer).appendChild(shadow);
		this.el.querySelector(layer).appendChild(unit);
	}
}
''';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);
  List<String Function(String)> renderPhase(Phase phase, Variant variant) {
    var scs = phase["SCs"] as Map<String, dynamic>;
    var nations = variant["Nations"] as List<dynamic>;
    return [
      (_) => _dippyMap,
      (elementID) =>
          "var map = new DippyMap(document.querySelector('#$elementID SVG'));",
      ...((variant["Graph"] as Map<String, dynamic>)["Nodes"]
              as Map<String, dynamic>)
          .keys
          .map((prov) {
        if (scs.containsKey(prov)) {
          var colorIdx = nations.indexOf(scs[prov]!);
          return (String elementID) {
            return "map.colorProvince('$prov', contrasts[$colorIdx]);";
          };
        } else {
          return (String elementID) {
            return "map.hideProvince('$prov');";
          };
        }
      }).toList(),
      (_) => "map.showProvinces();",
      (_) => "map.removeUnits();",
    ];
  }

  @override
  Widget build(context) {
    final game = context.watch<Game?>();
    final lastPhase = context.watch<Phase?>();
    final variant = context.watch<Variant?>();
    if (game == null || variant == null || lastPhase == null) {
      return const SpinnerWidget();
    }
    return StreamBuilder<List<int>>(
      stream: variant.mapSVG,
      builder: (context, mapSVG) {
        if (mapSVG.data == null) {
          return const SpinnerWidget();
        }
        return Column(
          children: [
            Text("map ${game["Desc"]}"),
            Expanded(
              child: InteractiveViewer(
                maxScale: 10,
                minScale: 0.1,
                child: HTMLWidget(
                  source: String.fromCharCodes(mapSVG.data!),
                  mutations: renderPhase(lastPhase, variant),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
