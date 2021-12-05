import 'package:corpulentpangolin/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'html_widget.dart';
import 'phase.dart';
import 'toast.dart';
import 'variant.dart';
import 'game_page.dart';

// Based on http://godsnotwheregodsnot.blogspot.se/2012/09/color-distribution-methodology.html.
const contrastColors = [
  "#F44336",
  "#2196F3",
  "#80DEEA",
  "#90A4AE",
  "#4CAF50",
  "#FFC107",
  "#F5F5F5",
  "#009688",
  "#FFEB3B",
  "#795548",
  "#E91E63",
  "#CDDC39",
  "#FF9800",
  "#D05CE3",
  "#9A67EA",
  "#FF6090",
  "#6EC6FF",
  "#80E27E",
  "#A98274",
  "#CFCFCF",
  "#FF34FF",
  "#1CE6FF",
  "#FFDBE5",
  "#FF7961",
  "#C66900",
  "#9C27B0",
  "#3F51B5",
  "#C8B900",
  "#C2185B",
  "#BA000D",
  "#607D8B",
  "#087F23",
  "#673AB7",
  "#0069C0",
  "#34515E",
  "#002984",
  "#004C40",
  "#FFFF6E",
  "#B4FFFF",
  "#6A0080",
  "#757DE8",
  "#04F757",
  "#CEFDAE",
  "#974D2B",
  "#974D2B",
  "#FF2F80",
  "#0CBD66",
  "#FF90C9",
  "#BEC459",
  "#0086ED",
  "#FFB500",
  "#0AA6D8",
  "#A05837",
  "#EEC3FF",
  "#456648",
  "#D790FF",
  "#6A3A4C",
  "#324E72",
  "#A4E804",
  "#CB7E98",
  "#0089A3",
  "#404E55",
  "#FDE8DC",
  "#5B4534",
  "#922329",
  "#3A2465",
  "#99ADC0",
  "#BC23FF",
  "#72418F",
  "#201625",
  "#FFF69F",
  "#549E79",
  "#9B9700",
  "#772600",
  "#6B002C",
  "#6367A9",
  "#A77500",
  "#7900D7",
  "#1E6E00",
  "#C8A1A1",
  "#885578",
  "#788D66",
  "#7A87A1",
  "#B77B68",
  "#456D75",
  "#6F0062",
  "#00489C",
  "#001E09",
  "#C2FF99",
  "#C0B9B2",
  "#CC0744",
  "#A079BF",
  "#C2FFED",
  "#372101",
  "#00846F",
  "#013349",
  "#300018",
  "#A1C299",
  "#7B4F4B",
  "#000035",
  "#DDEFFF",
  "#D16100",
  "#B903AA",
];
const contrastNeutral = "#f4d7b5";

String _dippyMap = r'''

function toggle(elOn, elOff) {
  elOn.style.display = 'block';
  elOff.style.display = 'none';
}

function getSVGData(svg, width) {
  return new Promise((res, rej) => {
    const work = () => {
      const scale = width / svg.clientWidth;
      const clone = svg.cloneNode(true);
      clone.setAttribute("width", svg.clientWidth * scale);
      clone.setAttribute("height", svg.clientHeight  * scale);
      const svgXML = new XMLSerializer().serializeToString(clone);
      const serializedSVG = btoa(unescape(encodeURIComponent(svgXML)));
      const snapshotImage = document.createElement("img");
      snapshotImage.style.width = svg.clientWidth * scale;
      snapshotImage.style.height = svg.clientHeight * scale;
      snapshotImage.src = "data:image/svg+xml;base64," + serializedSVG;
      snapshotImage.addEventListener("load", (_) => {
        if ("createImageBitmap" in window) {
          createImageBitmap(
            snapshotImage,
            0,
            0,
            snapshotImage.width,
            snapshotImage.height
          ).then((bitmap) => {
            const snapshotCanvas = document.createElement("canvas");
            snapshotCanvas.setAttribute("height", svg.clientHeight * scale);
            snapshotCanvas.setAttribute("width", svg.clientWidth * scale);
            snapshotCanvas.style.height = svg.clientHeight * scale;
            snapshotCanvas.style.width = svg.clientWidth * scale;
            snapshotCanvas
              .getContext("bitmaprenderer")
              .transferFromImageBitmap(bitmap);
            res(snapshotCanvas.toDataURL("image/png"));
          });
        } else {
          const snapshotCanvas = document.createElement("canvas");
          snapshotCanvas.setAttribute("height", svg.clientHeight * scale);
          snapshotCanvas.setAttribute("width", svg.clientWidth * scale);
          snapshotCanvas.style.height = svg.clientHeight * scale;
          snapshotCanvas.style.width = svg.clientWidth * scale;
          snapshotCanvas.getContext("2d").drawImage(snapshotImage, 0, 0);
          res(snapshotCanvas.toDataURL("image/png"));
        }
      });
    };
    let lookAgain = null;
    lookAgain = () => {
      setTimeout(() => {
        if (svg.clientWidth > 0) {
          work();
        } else {
          lookAgain();
        }
      }, 10);
    };
    lookAgain();
  });
}

const matrixReg = /matrix3d\((.*)\)/;

class Transform {
	constructor(opts = {}) {
		this.opts = opts;
		this.el = opts.el;
		this.viewPort = opts.viewPort;
		this.pzID = this.el.getAttribute("data-pz-id");
		const originString =
			this.el.style.transformOrigin ||
			this.el.clientWidth / 2 +
				"px " +
				this.el.clientHeight / 2 +
				"px 0px";
		const originParts = originString.split(" ").map((part) => {
			return Number.parseFloat(part);
		});
		const matrixString =
			this.el.style.transform ||
			"matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)";
		const match = matrixReg.exec(matrixString);
		const matrixParts = match[1].split(",").map((part) => {
			return Number.parseFloat(part);
		});
		this.scaleX = matrixParts[0];
		this.scaleY = matrixParts[5];
		this.transX = matrixParts[12];
		this.transY = matrixParts[13];
		this._origX = originParts[0];
		this._origY = originParts[1];
	}
	apply(delay = 0.0) {
		if (this.opts.minScale && this.opts.minScale > this.scaleX) {
			this.scaleX = this.opts.minScale;
		}
		if (this.opts.minScale && this.opts.minScale > this.scaleY) {
			this.scaleY = this.opts.minScale;
		}
		if (this.opts.maxScale && this.opts.maxScale < this.scaleX) {
			this.scaleX = this.opts.maxScale;
		}
		if (this.opts.maxScale && this.opts.maxScale < this.scaleY) {
			this.scaleY = this.opts.maxScale;
		}
		if (this.opts.maxTrans) {
			const rect = this.el.getBoundingClientRect();
			const viewPortRect = this.viewPort.getBoundingClientRect();
			const elLeftEdge = rect.x - viewPortRect.x;
			const maxHorizTrans = viewPortRect.width * this.opts.maxTrans;
			const tooMuchTransRight = elLeftEdge - maxHorizTrans;
			if (tooMuchTransRight > 0) {
				this.transX -= tooMuchTransRight;
			}
			const elRightEdge = rect.x - viewPortRect.x + rect.width;
			const tooMuchTransLeft =
				viewPortRect.width - maxHorizTrans - elRightEdge;
			if (tooMuchTransLeft > 0) {
				this.transX += tooMuchTransLeft;
			}
			const elTopEdge = rect.y - viewPortRect.y;
			const maxVertTrans = viewPortRect.height * this.opts.maxTrans;
			const tooMuchTransDown = elTopEdge - maxVertTrans;
			if (tooMuchTransDown > 0) {
				this.transY -= tooMuchTransDown;
			}
			const elBottomEdge = rect.y - viewPortRect.y + rect.height;
			const tooMuchTransUp =
				viewPortRect.height - maxVertTrans - elBottomEdge;
			if (tooMuchTransUp > 0) {
				this.transY += tooMuchTransUp;
			}
		}
		const newTransformOrigin =
			"" + this._origX + "px " + this._origY + "px 0px";
		const newTransform =
			"matrix3d(" +
			this.scaleX +
			",0,0,0,0," +
			this.scaleY +
			",0,0,0,0,1,0," +
			this.transX +
			"," +
			this.transY +
			",0,1)";
		if (delay > 0) {
			const ts = new Date().getTime();
			const animID = this.pzID + ts;
			document.getElementById(this.pzID).innerHTML =
				`
@keyframes ` +
				animID +
				` {
  from {
    transform-origin: ` +
				(this.el.style.transformOrigin || "50% 50%") +
				`;
	transform: ` +
				(this.el.style.transform ||
					"matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1)") +
				`;
  }
  to {
    transform-origin: ` +
				newTransformOrigin +
				`;
	transform: ` +
				newTransform +
				`;
  }
}
`;
			this.el.style.animationName = animID;
			this.el.style.animationDuration = "" + delay + "s";
		}
		this.el.style.transformOrigin =
			"" + this._origX + "px " + this._origY + "px 0px";
		this.el.style.transform =
			"matrix3d(" +
			this.scaleX +
			",0,0,0,0," +
			this.scaleY +
			",0,0,0,0,1,0," +
			this.transX +
			"," +
			this.transY +
			",0,1)";
		if (this.opts.onTransform) {
		  this.opts.onTransform(`transform: ${this.el.style.transform}; transform-origin: ${this.el.style.transformOrigin};`);
		}
	}
	get origX() {
		return this._origX;
	}
	get origY() {
		return this._origY;
	}
	set origX(newOrigX) {
		const delta = (this._origX - newOrigX) * (this.scaleX - 1);
		this.transX -= delta;
		this._origX = newOrigX;
	}
	set origY(newOrigY) {
		const delta = (this._origY - newOrigY) * (this.scaleY - 1);
		this.transY -= delta;
		this._origY = newOrigY;
	}
}

class BinaryEvent {
	constructor(onStart, onEnd) {
		this.onStart = onStart;
		this.onEnd = onEnd;
		this.timeout = null;
	}
	start(ms = 0) {
		if (!this.onStart || !this.onEnd) return;
		clearTimeout(this.timeout);
		this.onStart();
		if (ms) {
			this.timeout = setTimeout((_) => {
				this.onEnd();
			}, ms);
		}
	}
	end() {
		if (!this.onStart || !this.onEnd) return;
		clearTimeout(this.timeout);
		this.onEnd();
	}
}

class PZ {
	constructor(opts = {}) {
		this.opts = opts;
		this.binaryZoom = new BinaryEvent(opts.onZoomStart, opts.onZoomEnd);
		this.binaryPan = new BinaryEvent(opts.onPanStart, opts.onPanEnd);
		this.el = opts.el;
		this.el.setAttribute("data-pz-id", opts.pzid);
		if (!document.getElementById(opts.pzid)) {
			const pzStyle = document.createElement("style");
			pzStyle.setAttribute("id", opts.pzid);
			document.head.appendChild(pzStyle);
		}
		this.viewPort = opts.viewPort;
		this.zoomEndTimeout = null;
		this.viewPort.addEventListener("dblclick", (dblClickEvent) => {
			const trans = new Transform(this.opts);
			const rect = this.el.getBoundingClientRect();
			trans.origX = (dblClickEvent.clientX - rect.left) / trans.scaleX;
			trans.origY = (dblClickEvent.clientY - rect.top) / trans.scaleY;
			trans.scaleX *= 1.5;
			trans.scaleY *= 1.5;
			this.binaryZoom.start(300);
			trans.apply(0.5);
		});
		this.viewPort.addEventListener("wheel", (wheelEvent) => {
			wheelEvent.preventDefault();
			const trans = new Transform(this.opts);
			const rect = this.el.getBoundingClientRect();
			trans.origX = (wheelEvent.clientX - rect.left) / trans.scaleX;
			trans.origY = (wheelEvent.clientY - rect.top) / trans.scaleY;
			const scale =
				1 + wheelEvent.deltaY * (wheelEvent.ctrlKey ? -0.01 : -0.002);
			trans.scaleX *= scale;
			trans.scaleY *= scale;
			this.binaryZoom.start(300);
			trans.apply();
		});
		this.viewPort.addEventListener("mousedown", (mouseDownEvent) => {
			mouseDownEvent.preventDefault();
			let lastEvent = mouseDownEvent;
			const listeners = {};
			listeners["mousemove"] = (mouseMoveEvent) => {
				this.binaryPan.start();
				const trans = new Transform(this.opts);
				trans.transX += mouseMoveEvent.clientX - lastEvent.clientX;
				trans.transY += mouseMoveEvent.clientY - lastEvent.clientY;
				lastEvent = mouseMoveEvent;
				trans.apply();
			};
			listeners["mouseup"] = (mouseUpEvent) => {
				this.binaryPan.end();
				for (const eventName in listeners) {
					this.viewPort.removeEventListener(
						eventName,
						listeners[eventName]
					);
				}
			};
			listeners["mouseleave"] = (mouseLeaveEvent) => {
				const buttons = mouseLeaveEvent.buttons;
				listeners["mouseenter"] = (mouseEnterEvent) => {
					if (mouseEnterEvent.buttons !== buttons) {
						listeners["mouseup"](mouseEnterEvent);
					}
					this.viewPort.removeEventListener(
						"mouseenter",
						listeners["mouseenter"]
					);
					delete listeners["mouseenter"];
				};
				this.viewPort.addEventListener(
					"mouseenter",
					listeners["mouseenter"]
				);
			};
			for (const eventName in listeners) {
				this.viewPort.addEventListener(eventName, listeners[eventName]);
			}
		});
		this.touches = {};
		this.touching = false;
		this.lastSingleTouchStartAt = null;
		this.viewPort.addEventListener("touchstart", (touchStartEvent) => {
			if (touchStartEvent.touches.length === 1) {
				if (
					this.lastSingleTouchStartAt &&
					new Date().getTime() - this.lastSingleTouchStartAt < 300
				) {
					this.lastSingleTouchStartAt = null;
					const trans = new Transform(this.opts);
					const rect = this.el.getBoundingClientRect();
					trans.origX =
						(touchStartEvent.touches[0].clientX - rect.left) /
						trans.scaleX;
					trans.origY =
						(touchStartEvent.touches[0].clientY - rect.top) /
						trans.scaleY;
					trans.scaleX *= 1.5;
					trans.scaleY *= 1.5;
					this.binaryZoom.start(500);
					trans.apply(0.5);
					return;
				} else {
					this.lastSingleTouchStartAt = new Date().getTime();
				}
			}
			for (let i = 0; i < touchStartEvent.changedTouches.length; i++) {
				this.touches[touchStartEvent.changedTouches[i].identifier] =
					touchStartEvent.changedTouches[i];
			}
			if (this.touching) {
				return;
			}
			this.touching = true;
			const touchMoveListener = (touchMoveEvent) => {
				touchMoveEvent.preventDefault();
				const movement = this.averageMovement(
					touchMoveEvent.changedTouches
				);
				const trans = new Transform(this.opts);
				const rect = this.el.getBoundingClientRect();
				const pos = this.averagePos(touchMoveEvent.touches);
				trans.origX = (pos[0] - rect.left) / trans.scaleX;
				trans.origY = (pos[1] - rect.top) / trans.scaleY;
				trans.transX += movement[0];
				trans.transY += movement[1];
				if (touchMoveEvent.touches.length > 1) {
					this.binaryZoom.start();
					const ratio = this.distanceChangeRatio(
						touchMoveEvent.touches
					);
					trans.scaleX *= ratio;
					trans.scaleY *= ratio;
				}
				this.binaryPan.start();
				trans.apply();
				for (let i = 0; i < touchMoveEvent.changedTouches.length; i++) {
					this.touches[touchMoveEvent.changedTouches[i].identifier] =
						touchMoveEvent.changedTouches[i];
				}
			};
			const touchEndListener = (touchEndEvent) => {
				for (let i = 0; i < touchEndEvent.changedTouches.length; i++) {
					delete this.touches[
						touchEndEvent.changedTouches[i].identifier
					];
				}
				if (Object.keys(this.touches).length === 0) {
					this.binaryZoom.end();
					this.binaryPan.end();
					this.touching = false;
					this.viewPort.removeEventListener(
						"touchmove",
						touchMoveListener
					);
					this.viewPort.removeEventListener(
						"touchend",
						touchEndListener
					);
				}
			};
			this.viewPort.addEventListener("touchmove", touchMoveListener);
			this.viewPort.addEventListener("touchend", touchEndListener);
		});
	}
	distanceChangeRatio(touchList) {
		const oldTouches = [];
		const newTouches = [];
		for (let i = 0; i < touchList.length; i++) {
			const oldTouch = this.touches[touchList[i].identifier];
			if (oldTouch) {
				oldTouches.push(oldTouch);
				newTouches.push(touchList[i]);
			}
		}
		const oldDist = this.maxDist(oldTouches);
		const newDist = this.maxDist(newTouches);
		return newDist / oldDist;
	}
	maxDist(touchAry) {
		let max = -1;
		for (let idx1 = 0; idx1 < touchAry.length - 1; idx1++) {
			for (let idx2 = idx1 + 1; idx2 < touchAry.length; idx2++) {
				const t1 = touchAry[idx1];
				const t2 = touchAry[idx2];
				const dist = Math.pow(
					Math.pow(t1.clientX - t2.clientX, 2) +
						Math.pow(t1.clientY - t2.clientY, 2),
					0.5
				);
				if (dist > max) {
					max = dist;
				}
			}
		}
		return max;
	}
	averagePos(touchList) {
		const sum = [0.0, 0.0];
		for (let i = 0; i < touchList.length; i++) {
			sum[0] += touchList[i].clientX;
			sum[1] += touchList[i].clientY;
		}
		return [sum[0] / touchList.length, sum[1] / touchList.length];
	}
	averageMovement(touchList) {
		const sum = [0.0, 0.0];
		let len = 0.0;
		for (let i = 0; i < touchList.length; i++) {
			const oldTouch = this.touches[touchList[i].identifier];
			if (oldTouch) {
				sum[0] += touchList[i].clientX - oldTouch.clientX;
				sum[1] += touchList[i].clientY - oldTouch.clientY;
				len += 1;
			}
		}
		return [sum[0] / len, sum[1] / len];
	}
}

const SVG = "http://www.w3.org/2000/svg";

class Poi {
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

class Vec {
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

class DippyMap {
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
		const path = this.el.querySelector(`#${this.selEscape(province)}`);
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
		this.el.appendChild(copy);
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
		    copy.addEventListener("touchend", touchendHandler);
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
		const body = document.querySelector(`#${sourceId} #body`);
		const loc = this.centerOf(province);
		let unit = null;
		let opacity = 1;
		if (dislodged) {
			loc.x += 5;
			loc.y += 5;
			opacity = 0.73;
		}
		loc.y -= 11;
		if (hull != null) {
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

var _nextMapID = 0;

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  String color(Variant variant, String? nation) {
    if (nation == null) {
      return contrastNeutral;
    }
    final idx = variant.nations.indexOf(nation);
    if (idx == -1) {
      return contrastNeutral;
    }
    return contrastColors[idx % contrastColors.length];
  }

  String provinceInfo(
      BuildContext context, Phase phase, Variant variant, String prov) {
    final l10n = context.read<AppLocalizations>();
    prov = prov.split("/")[0];
    final res = StringBuffer(variant.provinceLongNames[prov] ?? prov);
    if (phase.supplyCenters.containsKey(prov)) {
      res.write(" (${phase.supplyCenters[prov]})");
    }
    if (phase.units.containsKey(prov)) {
      var type = phase.units[prov]!.type;
      switch (type) {
        case "Army":
          type = l10n.army;
          break;
        case "Fleet":
          type = l10n.fleet;
          break;
      }
      res.write(", $type (${phase.units[prov]!.nation})");
    }
    return res.toString();
  }

  List<String> renderProvinces(Phase phase, Variant variant) {
    return variant.graph.nodes.keys.expand((prov) {
      final List<String> res = [];
      if (phase.supplyCenters.containsKey(prov)) {
        res.add(
            "map.colorProvince('$prov', '${color(variant, phase.supplyCenters[prov])}');");
      } else {
        res.add("map.hideProvince('$prov');");
      }
      res.add(
          "map.addClickListener('$prov', () => { flutter_cb({'infoClicked': '$prov'}) }, { nohighlight: true, permanent: true, touch: true });");
      return res;
    }).toList();
  }

  List<String> renderPhase(Phase phase, Variant variant) {
    return [
      "const svg = mapViewport.querySelector('#map SVG');",
      "const snapshot = mapViewport.querySelector('#map-snapshot');",
      "const mapContainer = mapViewport.querySelector('#map-container');",
      "const map = new DippyMap(svg);",
      ...renderProvinces(phase, variant),
      "map.showProvinces();",
      "map.removeUnits();",
      ...phase.units.keys.map((prov) {
        return "map.addUnit('unit${phase.units[prov]!.type}', '$prov', '${color(variant, phase.units[prov]!.nation)}', false, false);";
      }),
    ];
  }

  Function(Map<String, dynamic>) jsCallback(
      BuildContext context, Phase phase, Variant variant, Style style) {
    return (msg) {
      if (msg.containsKey("infoClicked")) {
        toast(context,
            provinceInfo(context, phase, variant, "${msg["infoClicked"]}"));
      } else if (msg.containsKey("mapTransformStyle")) {
        style.content = "${msg["mapTransformStyle"]}";
      } else {
        debugPrint("$msg");
      }
    };
  }

  @override
  Widget build(context) {
    _nextMapID++;
    final svgs = context.watch<SVGBundle?>();
    final phase = context.watch<Phase?>();
    final variant = context.watch<Variant?>();
    final mapStyle = context.read<Style>();
    if (svgs == null) {
      return const SpinnerWidget();
    }
    if (svgs.err != null || variant?.err != null || phase?.err != null) {
      return Column(
        children: [
          Text("Variant error: ${variant?.err}"),
          Text("SVGBundle error: ${svgs.err}"),
          Text("Phase error: ${phase?.err}"),
        ],
      );
    }
    return HTMLWidget(
      source: '''
<div class="map-element-wrapper" id="map-element-wrapper-$_nextMapID">
  <div id="map-viewport-$_nextMapID" style="height:100%;background-color:black;overflow:hidden;">
    <div id="map-container" style="${mapStyle.content}">
      <div id="map">${svgs.html}</div>
      <img id="map-snapshot" style="display: none;" />
    </div>
  </div>
  <script>
    (() => {
      const mapViewport = document.getElementById('map-viewport-$_nextMapID');
      const flutter_cb = (m) => { window.flutter_cb_json(JSON.stringify(m)); };

      $_dippyMap

      ${phase != null && variant != null ? renderPhase(phase, variant).join("\n") : ""}

      getSVGData(svg, 1280).then((data) => {
        snapshot.width = svg.clientWidth;
        snapshot.style.width = svg.clientWidth;
        snapshot.height = svg.clientHeight;
        snapshot.style.height = svg.clientHeight;
        snapshot.src = data;

        new PZ({
          pzid: 'dip-map-pz',
          minScale: 0.5,
          maxScale: 20,
          maxTrans: 0.5,
          el: mapContainer,
          viewPort: mapViewport,
          onTransform: (style) => { flutter_cb({ mapTransformStyle: style }); },
          onZoomStart: () => { toggle(snapshot, svg); },
          onZoomEnd: () => { toggle(svg, snapshot); },
          onPanStart: () => { toggle(snapshot, svg); },
          onPanEnd: () => { toggle(svg, snapshot); },
        });
      });
    })();
  </script>
</div>
''',
      key: const Key("map"),
      callbacks: phase != null && variant != null
          ? {
              "flutter_cb_json": (m) =>
                  jsCallback(context, phase, variant, mapStyle)(json.decode(m))
            }
          : {},
    );
  }
}
