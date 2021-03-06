import * as p from "core/properties"
import {LayoutDOM, LayoutDOMView} from "models/layouts/layout_dom"

# This defines some default options for the Graph3d feature of vis.js
OPTIONS =
  width:  '600px'
  height: '390px'
  style: 'dot'
  showPerspective: true
  showGrid: true
  keepAspectRatio: false
  verticalRatio: 1.0
  showLegend: true
  cameraPosition:
    horizontal: -0.35
    vertical: 0.22
    distance: 2.6
  xLabel: 'Total Labor Income'
  yLabel: 'Total Capital Income'
  zLabel: 'Effective Tax Rate'
  xMin: 0
  xMax: 500000

export class Scatter3dView extends LayoutDOMView

  initialize: (options) ->
    super(options)

    url = "https://cdnjs.cloudflare.com/ajax/libs/vis/4.16.1/vis.min.js"

    window.visjsInits ||= []
    window.visjsInits.push(() => @_init())

    visjsCdnTag = document.querySelector("script[src=\"#{url}\"]")

    unless visjsCdnTag?
      script = document.createElement('script')
      script.src = url
      script.async = false
      script.onreadystatechange = script.onload = () =>
        for initFunction in window.visjsInits
          initFunction()
      document.querySelector("head").appendChild(script)

  _init: () ->
    @_scatter_graph = new vis.Graph3d(@el, @get_data(), OPTIONS)

    @connect(@model.data_source.change, () =>
        @_scatter_graph.setData(@get_data())
    )

    window.scatter_graph = @_scatter_graph

  get_data: () ->
    data = new vis.DataSet()
    source = @model.data_source
    for i in [0...source.get_length()]
      data.add({
        x:     source.get_column(@model.x)[i]
        y:     source.get_column(@model.y)[i]
        z:     source.get_column(@model.z)[i]
      })
    return data

export class Scatter3d extends LayoutDOM

  default_view: Scatter3dView

  type: "Scatter3d"

  @define {
    x:           [ p.String           ]
    y:           [ p.String           ]
    z:           [ p.String           ]
    color:       [ p.String           ]
    data_source: [ p.Instance         ]
  }
